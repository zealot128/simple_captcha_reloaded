require 'rails_helper'
require 'simple_captcha_reloaded'
require "rack/test"
require 'uglifier'


describe SimpleCaptchaReloaded::Middleware do
  include Rack::Test::Methods
  let(:stack) { proc{[200,{},['Hello, world.']]} }
  let(:app) { SimpleCaptchaReloaded::Middleware.new stack }

  specify "generates captcha" do
    SimpleCaptchaReloaded::Data.create!(key: '123123', value: 'ABCABC')
    response = get '/simple_captcha', { code: '123123' }
    response.inspect
    expect(response.status).to eql 200
    expect(response.header['Content-Type']).to eql 'image/jpeg'
    expect(response.header['Content-Length'].to_i).to be > 100
    expect(response.body).to include('JFIF')
  end

  specify 'missing key' do
    response = get '/simple_captcha', code: '123123'
    expect(response.status).to eql 404
  end

  specify 'refresh captcha' do
    SimpleCaptchaReloaded::Data.create!(key: '123123', value: 'ABCABC')
    response = get '/simple_captcha', {}, 'rack.session' => {:captcha =>'123123'}

    expect(response.status).to eql 200
    expect(response.header['Content-Type']).to eql 'text/javascript; charset=utf-8'
    expect(SimpleCaptchaReloaded::Data.where(key: '123123').first).to be_nil
    code = response.body[/code=([^&]+)/, 1]
    expect(SimpleCaptchaReloaded::Data.where(key: code).first).to be_present
    Uglifier.compile(response.body) # check for js syntax errors
  end
end
