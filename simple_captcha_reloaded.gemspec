$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_captcha_reloaded/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'simple_captcha_reloaded'
  s.version     = SimpleCaptchaReloaded::VERSION
  s.authors     = ['Stefan Wienert']
  s.email       = ['info@stefanwienert.de']
  s.homepage    = 'https://github.com/zealot128/simple_captcha_reloaded'
  s.summary     = 'Captcha library which uses imagemagick to create captchas'
  s.description = ''
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.1'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-shell'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-doc'
  s.add_development_dependency 'uglifier'
  s.add_development_dependency 'slim-rails'
  s.add_development_dependency 'simple_form'
  s.add_development_dependency 'database_cleaner'
end
