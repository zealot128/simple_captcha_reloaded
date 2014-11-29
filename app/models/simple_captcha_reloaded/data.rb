module SimpleCaptchaReloaded
  class Data < ActiveRecord::Base

    def self.generate_captcha_id(old_key: nil)
      if old_key
        SimpleCaptchaReloaded::Data.where(key: old_key).delete_all
      end
      key, value = SimpleCaptchaReloaded::Config.generate_challenge
      SimpleCaptchaReloaded::Data.create!(key: key, value: value)
      key
    end

    def self.clear
      SimpleCaptchaReloaded::Data.where('created_at < ?', 1.hour.ago).delete_all
    end

  end
end
