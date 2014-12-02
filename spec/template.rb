generate(:controller, 'forms -t false --no_helper --no_assets')
route "get 'forms/simple_form'"
route "post 'forms/simple_form' => 'forms#simple_form_submit'"

route "get 'forms/manual'"
route "post 'forms/manual' => 'forms#manual_submit'"

route "get 'forms/formtastic'"
route "post 'forms/formtastic' => 'forms#formtastic_submit'"

remove_file 'app/controllers/forms_controller.rb'
create_file 'app/controllers/forms_controller.rb', %q{
class FormsController < ApplicationController
  def simple_form
    @model = FormModel.new
  end

  def simple_form_submit
    @model = FormModel.new(params[:form_model])
    if @model.valid_with_captcha?
      render text: 'valid', layout: false
    else
      render text: "invalid: #{@model.errors.full_messages.join(' ')}", layout: false, status: 403
    end
  end

  def manual
  end

  def manual_submit
    if captcha_valid?(params[:captcha_key], params[:captcha])
      render text: 'valid', layout: false
    else
      render text: 'invalid'
    end
  end

  def formtastic
    @model = FormModel.new
  end

  def formtastic_submit
    @model = FormModel.new(params[:form_model])
    if @model.valid_with_captcha?
      render text: 'valid', layout: false
    else
      render text: "invalid: #{@model.errors.full_messages.join(' ')}", layout: false, status: 403
    end
  end
end
}

create_file 'app/models/form_model.rb', %q{
class FormModel
  include ActiveModel::Model
  include SimpleCaptchaReloaded::Model
  attr_accessor :title
  validates :title, presence: true
end
}

create_file 'config/initializers/simple_captcha.rb', %q{
if defined?(SimpleForm)
  require 'simple_captcha_reloaded/adapters/simple_form'
end
if defined?(Formtastic)
  require 'simple_captcha_reloaded/adapters/formtastic'
end
}

create_file "app/views/forms/simple_form.html.slim", %q{
= simple_form_for @model, url: '' do |f|
  = f.input :title
  = f.input :captcha, as: :simple_captcha
  = f.submit
}
create_file "app/views/forms/formtastic.html.slim", %q{
= semantic_form_for @model, url: '' do |f|
  = f.input :title
  = f.input :captcha, as: :simple_captcha
  = f.submit
}
create_file "app/views/forms/manual.html.slim", %q{
= form_tag '' do |f|
  = simple_captcha(key: :captcha_key, value: :captcha, refresh_button: true)
  = submit_tag 'send'
}
remove_file 'app/assets/javascripts/application.js'
create_file 'app/assets/javascripts/application.js', <<DOC
//= require jquery
//= require jquery_ujs
//= require turbolinks
DOC

remove_file 'config/database.yml'
adapter = if defined?(PG)
            'postgresql'
          elsif defined?(Mysql2)
            'mysql2'
          else
            'sqlite3'
          end
create_file 'config/database.yml', <<DOC
development:
  database: simple_captcha_reloaded_development
  adapter: #{adapter}
  pool: 5
test:
  database: simple_captcha_reloaded_test
  adapter: #{adapter}
  pool: 5
DOC
