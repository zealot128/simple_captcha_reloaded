class SimpleCaptchaInput < Formtastic::Inputs::StringInput
  def to_html
    set_options!
    captcha = SimpleCaptchaReloaded.generate_captcha(id: options[:captcha][:id], request: template.request)
    input_wrapping do
      label_html <<
      image_tag(captcha) <<
      captcha_key(captcha) <<
      builder.text_field(method, input_html_options) <<
      refresh_button(captcha)
    end
  end

  def set_options!
    default_options = {
      refresh_button: true,
      id: 'simple_captcha_wrapper'
    }
    options[:wrapper_html] ||= {}
    options[:captcha] ||= {}
    options[:captcha].reverse_merge!(default_options)
    options[:wrapper_html][:id] ||= options[:captcha][:id]
  end

  def image_tag(captcha)
    template.content_tag(:img, nil, src: captcha[:captcha_url], alt: 'Captcha', class: 'simple-captcha-image')
  end

  def captcha_key(captcha)
    builder.hidden_field :captcha_key, value: captcha[:captcha_id]
  end

  def refresh_button(captcha)
    template.content_tag :div, class: 'simple-captcha-reload' do
      template.link_to captcha[:refresh_url], class: options[:captcha][:refresh_button_class], data: {remote: true} do
        I18n.t('simple_captcha_reloaded.refresh_button_html')
      end
    end
  end


end
