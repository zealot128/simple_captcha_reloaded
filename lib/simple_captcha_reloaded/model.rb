module SimpleCaptchaReloaded::Model
  attr_accessor :captcha_key
  attr_accessor :captcha
  def valid_with_captcha?
    valid? & captcha_valid?
  end

  def save_with_captcha(*args)
    valid_with_captcha? & save(*args)
  end

  def captcha_valid?
    if @last_result.nil?
      @last_result = begin
                       data = SimpleCaptchaReloaded::Data.where(key: captcha_key).first
                       if !data
                         errors.add :captcha, I18n.t('simple_captcha_reloaded.errors.missing_captcha')
                         false
                       elsif !captcha.present?
                         errors.add :captcha, I18n.t('simple_captcha_reloaded.errors.blank')
                         false
                       elsif not data.valid_captcha?(captcha)
                         errors.add :captcha, I18n.t('simple_captcha_reloaded.errors.wrong')
                         false
                       else
                         true
                       end
                     end
    end
    @last_result
  end

end
