module SimpleCaptchaReloaded
  module ViewHelper
    # key: params[key] for the captcha id
    # value: params[value] for the user-answer
    # refresh_button: show refresh button
    # id: wrapper id for the element, to refresh the captcha
    def simple_captcha(key: :captcha_key, value: :captcha, refresh_button: true, id: 'simple_captcha_wrapper')
      captcha = SimpleCaptchaReloaded.generate_captcha(id: id, request: request)
      render 'simple_captcha_reloaded/simple_captcha_reloaded',
        key: key,
        value: value,
        captcha: captcha,
        refresh_button: refresh_button,
        id: id
    end
  end
end
