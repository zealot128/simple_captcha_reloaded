module SimpleCaptchaReloaded
  module ControllerHelper
    def captcha_valid?(key, value)
      SimpleCaptchaReloaded::Data.valid_captcha?(key, value)
    end
  end
end
