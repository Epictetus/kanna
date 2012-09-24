# Pera

Pera connects Ruby on Rails with Phonegap the mobile application framework.
Pera enables us to build mobile applications in Rails-like development style.

## Installation

Add this line to your application's Gemfile:

    gem 'pera'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pera

## Usage

Run the generator,

    $ rails g pera:install

Run guard

    $ guard

Setup ios project,

    $ rake pera:ios:init

Run app on ios, (need to install ios-sim)

    $ rake pera:ios:build


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
