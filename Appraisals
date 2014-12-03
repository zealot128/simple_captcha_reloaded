RAILS_STABLE = '~> 4.1.0'
RAILS_LATEST = '~> 4.2.0.rc1'
SIMPLE_FORM_STABLE = '~> 3.0.0'
SIMPLE_FORM_LATEST = '~> 3.1.0.rc2'
FORMTASTIC_STABLE = '~> 2.3.1'
FORMTASTIC_LATEST = '~> 3.1.2'

appraise "rails-stable" do
  gem "rails", RAILS_STABLE
  gem 'simple_form', SIMPLE_FORM_STABLE
  gem 'pg'
end
appraise "rails-latest" do
  gem "rails", RAILS_LATEST
  gem 'simple_form', '~> 3.0.0'
  gem 'pg'
end
appraise "simple_form-latest" do
  gem 'simple_form', SIMPLE_FORM_LATEST
  gem 'rails', RAILS_STABLE
  gem 'pg'
end
appraise "formtastic-latest" do
  gem 'rails', RAILS_STABLE
  gem 'formtastic', FORMTASTIC_LATEST
  gem 'pg'
end
appraise "formtastic-stable" do
  gem 'rails', RAILS_STABLE
  gem 'formtastic', FORMTASTIC_STABLE
  gem 'pg'
end
appraise 'mysql' do
  gem 'simple_form', SIMPLE_FORM_LATEST
  gem 'rails', RAILS_STABLE
  gem 'mysql2'
end
