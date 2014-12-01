# Simple Captcha Reloaded

[![Build Status](https://travis-ci.org/zealot128/simple_captcha_reloaded.svg?branch=master)](https://travis-ci.org/zealot128/simple_captcha_reloaded)
[![Gem Version](https://badge.fury.io/rb/simple_captcha_reloaded.svg)](http://badge.fury.io/rb/simple_captcha_reloaded)

This is a rewrite of the popular Simple-Captcha Gem. Similarily to Simple-Captcha, it provides an easy way to integrate a Captcha into a Rails appliaction. In comparison to the older Gem(s), I decided to drop support for ancient versions of Rails + Formtastic + Mongoid, but also add specs and support for SimpleForm.

## Features

* Works with Rails 4.1+, Ruby 2.0+ (keyword arguments)
* Integrated into Model validation flow
* Optional controller integration for custom flow
* Uses a database table to track random captchas
* Uses imagemagick to generate the captcha and stream it to the client, without file access

## Prerequisites

This needs Rails (4.1+), ActiveRecord with a database (all should be fine) and imagemagick.

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

this adds 2 new methods: ``valid_with_captcha?`` and ``save_with_captcha`` to the model. Use it like this in controller:

```
class MessagesController < ApplicationController
  def submit
    @message = Message.new(message_params)
    if @message.save_with_captcha
      ...
    else
      render :new
    end
  end

  def message_params
    params.require(:message).permit(..., :captcha, :captcha_key)
  end
end
```

Make sure to whiteliste the attributes ``captcha`` and ``captcha_key`` with Strong Parameters.


### Integration II - Controller

## Displaying Captcha

### Simple Form
### Formtastic
### Default Rails form helpers

## Customizing

### Captcha Options

```ruby
# Default Options
SimpleCaptchaReloaded::Config.tap do |config|
  config.captcha_path = '/simple_captcha'
  config.image = SimpleCaptchaReloaded::Image.new
  config.characters = %w[a b c d e f g h j k m n p q r s t u v w x y z 0 2 3 4 5 6 8 9]
  config.length = 6
end
```

To change the appearance of the Captcha, initialize a SimpleCaptchaReloaded::Image.new with different parameters:

```ruby
SimpleCaptchaReloaded::Config.new(implode: :medium,
    distortion: :random,
    image_styles: IMAGE_STYLES.slice('simply_red', 'simply_green', 'simply_blue'),
    noise: 0,
    size: '100x28',
    image_magick_path: '',
    tmp_path: nil
    )

# whereas IMAGE_STYLES are:
IMAGE_STYLES = {
  'embosed_silver'  => ['-fill darkblue', '-shade 20x60', '-background white'],
  'simply_red'      => ['-fill darkred', '-background white'],
  'simply_green'    => ['-fill darkgreen', '-background white'],
  'simply_blue'     => ['-fill darkblue', '-background white'],
  'distorted_black' => ['-fill darkblue', '-edge 10', '-background white'],
  'all_black'       => ['-fill darkblue', '-edge 2', '-background white'],
  'charcoal_grey'   => ['-fill darkblue', '-charcoal 5', '-background white'],
  'almost_invisible' => ['-fill red', '-solarize 50', '-background white']
}
```


## Contributing

Report bugs/feature requests to the Github issues.
If you'd like to contribute, here a little setup guide.
The Gem uses **Appraisal**, to create various configuration Gem sets. For each Gem set, a new dummy app will be automatically created.

1. Fork, and clone
2. ``bundle``
3. ``appraisal install``
4. ``appraisal rails-stable make regenerate`` To build the dummy app with the Rails-Stable configuration
4. ``appraisal rails-stable rspec`` To run tests

If you need to add new controller methods to the dummy app, have a look at ``spec/template.rb``

