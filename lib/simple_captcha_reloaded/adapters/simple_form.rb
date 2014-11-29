class SimpleCaptchaInput < SimpleForm::Inputs::StringInput
  def input
    set_options
    code = get_code

    input = super
    refresh = if options[:captcha][:refresh_button]
                refresh_button(code)
              else
                ""
              end
    (image_tag(code) + captcha_key(code) + input + refresh).html_safe
  end

  protected

  def refresh_button(code)
    binding.pry
  end

  def set_options
    options[:wrapper_html] ||= {}
    options[:captcha] ||= {}
    options[:captcha].reverse_merge!(default_options)
    options[:wrapper_html][:id] ||= options[:captcha][:id]
  end

  def get_code
    old_key = template.request.session[:captcha]
    SimpleCaptchaReloaded::Data.generate_captcha_id(old_key: old_key)
  end


  def image_tag(code)
    url = SimpleCaptchaReloaded::Config.image_url(code, template.request, id: options[:captcha][:id])
    template.content_tag(:img, nil, src: url, alt: 'Captcha', class: 'simple-captcha-image')
  end

  def captcha_key(code)
    @builder.hidden_field :captcha_key, value: code
  end

  def default_options
    {
      refresh_button: true,
      id: 'simple_captcha_wrapper'
    }
  end
end
