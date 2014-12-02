require 'simple_captcha_reloaded/view_helper'
require 'simple_captcha_reloaded/controller_helper'
module SimpleCaptchaReloaded
  class Engine < ::Rails::Engine
    isolate_namespace SimpleCaptchaReloaded
    initializer "simple_captcha.load" do |app|
      ActiveSupport.on_load :action_controller do
        helper SimpleCaptchaReloaded::ViewHelper
        ActionController::Base.send(:include, SimpleCaptchaReloaded::ControllerHelper)
      end
      app.middleware.use SimpleCaptchaReloaded::Middleware
    end
    config.after_initialize do
      if defined?(SimpleForm)
        require 'simple_captcha_reloaded/adapters/simple_form'
      end
      if defined?(Formtastic)
        require 'simple_captcha_reloaded/adapters/formtastic'
      end
    end

  end
end
