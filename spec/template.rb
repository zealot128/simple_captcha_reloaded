generate(:controller, 'forms -t false --no_helper --no_assets')
route "post 'forms/simple_form' => 'forms#simple_form_submit'"
route "get 'forms/simple_form'"

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

create_file "app/views/forms/simple_form.html.slim", %q{
= simple_form_for @model, url: '' do |f|
  = f.input :title
  = f.input :captcha, as: :simple_captcha
  = f.submit
}
