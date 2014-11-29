require 'rails_helper'

describe 'Form', js: true do
  specify 'SimpleForm' do
    visit '/forms/simple_form'
    find('.simple-captcha-image')

    value = SimpleCaptchaReloaded::Data.first.value
    fill_in 'Captcha', with: value
    fill_in "Title", with: 'blah'

    click_on 'Create'
    expect(find('body').text).to eql 'valid'
  end

  specify 'Refresh Button' do
    visit '/forms/simple_form'
    find('.simple-captcha-image')

    click_on 'refresh'

    click_on 'Create'
    expect(find('body').text).to eql 'valid'
  end
end
