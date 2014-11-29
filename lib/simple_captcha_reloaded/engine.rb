module SimpleCaptchaReloaded
  class Engine < ::Rails::Engine
    isolate_namespace SimpleCaptchaReloaded
    initializer "simple_captcha.load" do |app|
      if defined?(SimpleForm)
        require 'simple_captcha_reloaded/adapters/simple_form'
      end
      app.middleware.use SimpleCaptchaReloaded::Middleware
    end

  end
end
