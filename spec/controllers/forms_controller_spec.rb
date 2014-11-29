require 'rails_helper'


describe FormsController do
  render_views
  specify 'happy path' do
    get 'simple_form'
    captcha = SimpleCaptchaReloaded::Data.first
    expect(captcha).to be_present
    expect(response.body).to include captcha.key

    post 'simple_form_submit', form_model: {
      title: 'foobar',
      captcha: captcha.value.upcase,
      captcha_key: captcha.key
    }
    expect(response.body).to eql 'valid'
  end

  specify 'wrong captcha' do
    get 'simple_form'
    captcha = SimpleCaptchaReloaded::Data.first
    post 'simple_form_submit', form_model: {
      captcha: 'blargheer',
      captcha_key: captcha.key
    }
    expect(response.body).to include 'invalid'
    # also validates title
    expect(response.body).to include "Title can't be blank"
    expect(response.body).to include I18n.t('simple_captcha_reloaded.errors.wrong')
    expect(response).to_not be_success
  end
end
