class SimpleCaptchaReloaded::Middleware
  DEFAULT_SEND_FILE_OPTIONS = {
    :type         => 'application/octet-stream'.freeze,
    :disposition  => 'attachment'.freeze,
  }.freeze

  def initialize(app, options={})
    @app = app
  end

  def call(env)
    @env = env
    SimpleCaptchaReloaded::Data.clear
    if env["REQUEST_METHOD"] == "GET" && captcha_path?(env['PATH_INFO'])
      if request.params.present? && (code = request.params['code']) && code.present?
        make_image(code)
      else
        refresh_code
      end
    else
      @app.call(env)
    end
  end

  protected

  def request
    Rack::Request.new(@env)
  end

  def make_image(code)
    if !d = SimpleCaptchaReloaded::Data.find_by_key(code)
      not_found
    else
      blob = SimpleCaptchaReloaded::Config.image.generate(d.value)
      send_data(blob, type: 'image/jpeg', disposition: 'inline', filename:  'simple_captcha.jpg')
    end
  end

  def refresh_code
    code = SimpleCaptchaReloaded::Data.generate_captcha_id(old_key: request.session[:captcha])
    request.session[:captcha] = code
    id = request.params['id'] || 'simple_captcha'
    url = SimpleCaptchaReloaded::Config.image_url(code, request)
    body = %Q{
      $("##{id} img").attr('src', '#{url}');
      $("##{id} input[type=hidden]").attr('value', '#{code}');
    }
    headers = {
      'Content-Type' => 'text/javascript; charset=utf-8',
      "Content-Disposition" => "inline; filename='captcha.js'",
      "Content-Length" => body.length.to_s
    }
    [200, headers, [body]]
  end

  def captcha_path?(request_path)
    request_path.include?(SimpleCaptchaReloaded::Config.captcha_path)
  end

  def send_data(response_body, options = {})
    status = options[:status] || 200
    headers = {"Content-Disposition" => "#{options[:disposition]}; filename='#{options[:filename]}'", "Content-Type" => options[:type], 'Content-Transfer-Encoding' => 'binary', 'Cache-Control' => 'private'}

    [status, headers, [response_body]]
  end

  def not_found
    [404, {}, []]
  end

end
