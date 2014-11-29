begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
if File.exists?(APP_RAKEFILE)
  load 'rails/tasks/engine.rake'
end
ENV['TEMPLATE'] = 'spec/template.rb'
ENV['ENGINE'] = 'simple_captcha_reloaded'
require 'rails/dummy/tasks'
require 'rspec-rails'


require 'pry'
Bundler::GemHelper.install_tasks

