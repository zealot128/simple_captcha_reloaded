require 'simple_captcha_reloaded/engine'
require 'simple_captcha_reloaded/image'
require 'simple_captcha_reloaded/config'
require 'simple_captcha_reloaded/model'
require 'simple_captcha_reloaded/middleware'

module SimpleCaptchaReloaded
  def self.generate_captcha(id:, request:, old_key: request.session[:captcha])
    captcha_id = SimpleCaptchaReloaded::Data.generate_captcha_id(old_key: old_key)
    captcha_url = SimpleCaptchaReloaded::Config.image_url(captcha_id, request)
    refresh_url = SimpleCaptchaReloaded::Config.refresh_url(request, id)
    {
      captcha_id: captcha_id,
      captcha_url: captcha_url,
      refresh_url: refresh_url
    }

  end
end
