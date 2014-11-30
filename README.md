# Simple Captcha Reloaded

This is a rewrite of the popular Simple-Captcha Gem. Similarily to Simple-Captcha, it provides an easy way to integrate a Captcha into a Rails appliaction. In comparison to the older Gem(s), I decided to drop support for ancient versions of Rails + Formtastic + Mongoid, but also add specs and support for SimpleForm.

## Features

* Works with Rails 4.1+
* Integrated into Model validation flow
* Optional controller integration for custom flow
* Uses a database table to track random captchas
* Uses imagemagick to generate the captcha and stream it to the client, without file access

## Prerequisites

Mac:

```
brew install imagemagick ghostscript
```

Linux:

```
apt-get install imagemagick ghostscript
```

## Usage

Put it into your Gemfile:

```ruby
gem 'simple_captcha_reloaded'
```

and run ``bundle install``.


### Integration 1: Model based

Just integrate the module into on of your ActiveModel::Model compliant Models:

```

class Message < ActiveRecord::Base
  include SimpleCaptchaReloaded::Model
end
```

this adds 2 new methods: ``valid_with_captcha?`` and ``save_with_captcha`` to the model.



