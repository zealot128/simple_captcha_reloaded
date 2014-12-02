require 'rails_helper'

describe 'Form', js: true do
  if defined?(SimpleForm)
    describe 'SimpleForm' do
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

        click_on 'Refresh'
        sleep 1
        expect( SimpleCaptchaReloaded::Data.count ).to eql 2
        captcha = SimpleCaptchaReloaded::Data.order('id desc').first
        expect(page.body).to include captcha.key
        fill_in 'Captcha', with: captcha.value
        fill_in "Title", with: 'blah'

        click_on 'Create'
        expect(find('body').text).to eql 'valid'
      end
    end
  end
  specify 'Default Helper + Refresh' do
    visit '/forms/manual'
    click_on 'Refresh'
    sleep 1
    expect( SimpleCaptchaReloaded::Data.count ).to eql 2
    captcha = SimpleCaptchaReloaded::Data.order('id desc').first
    expect(page.body).to include captcha.key
    fill_in 'captcha', with: captcha.value
    click_on 'send'
    expect(find('body').text).to eql 'valid'
  end
  if defined?(Formtastic)
    describe 'Formtastic' do
      specify 'Easy' do
        visit '/forms/formtastic'
        find('.simple-captcha-image')

        value = SimpleCaptchaReloaded::Data.first.value
        fill_in 'Captcha', with: value
        fill_in "Title", with: 'blah'

        click_on 'Create'
        expect(find('body').text).to eql 'valid'
      end

      specify 'Refresh Button' do
        visit '/forms/formtastic'
        find('.simple-captcha-image')

        click_on 'Refresh'
        sleep 1
        expect( SimpleCaptchaReloaded::Data.count ).to eql 2
        captcha = SimpleCaptchaReloaded::Data.order('id desc').first
        expect(page.body).to include captcha.key
        fill_in 'Captcha', with: captcha.value
        fill_in "Title", with: 'blah'

        click_on 'Create'
        expect(find('body').text).to eql 'valid'
      end
    end
  end
end
