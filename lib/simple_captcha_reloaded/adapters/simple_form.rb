require 'simple_form/version'
# to accommodate for the Bootstrap 3 Simple Form config
superclass = SimpleForm::Inputs::StringInput
if defined?(StringInput)
  superclass = StringInput
end
class SimpleCaptchaInput < superclass
  def input(wrapper_options=nil)
    set_options
    @captcha = SimpleCaptchaReloaded.generate_captcha(id: options[:captcha][:id], request: template.request)

    if SimpleForm::VERSION[/^3\.0/]
      input = super()
    else
      input = super
    end
    refresh = if options[:captcha][:refresh_button]
                refresh_button(@captcha)
              else
                ""
              end
    [
      image_tag(@captcha),
      captcha_key(@captcha),
      input,
      refresh
    ].join.html_safe
  end

  protected

  def refresh_button(captcha)
    template.content_tag :div, class: 'simple-captcha-reload' do
      template.link_to captcha[:refresh_url], class: options[:captcha][:refresh_button_class], data: {remote: true} do
        I18n.t('simple_captcha_reloaded.refresh_button_html')
      end
    end
  end

  def set_options
    options[:wrapper_html] ||= {}
    options[:captcha] ||= {}
    options[:captcha].reverse_merge!(default_options)
    options[:wrapper_html][:id] ||= options[:captcha][:id]
  end

  def image_tag(captcha)
    template.content_tag(:img, nil, src: captcha[:captcha_url], alt: 'Captcha', class: 'simple-captcha-image')
  end

  def captcha_key(captcha)
    @builder.hidden_field :captcha_key, value: captcha[:captcha_id]
  end

  def default_options
    {
      refresh_button: true,
      id: 'simple_captcha_wrapper'
    }
  end
end
