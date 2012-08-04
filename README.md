# Lbank

[![Build Status](http://travis-ci.org/laurynas/lbank.png)](http://travis-ci.org/laurynas/lbank)

Fetches currency rates from Lithuanian Central Bank website http://lbank.lt.
Does currency conversion.
Supports historic currency rates.

## Installation

Add this line to your application's Gemfile:

    gem 'lbank'

## Usage

Get hash of current currency rates

    Lbank.currency_rates

Get hash of historic currency rates

    Lbank.currency_rates(Date.new(2012, 8, 4))

Convert currency

    Lbank.convert_currency(10, 'LTL', 'EUR')

Convert currency using historic rates

    Lbank.convert_currency(10, 'LTL', 'EUR', Date.new(2012, 8, 4))

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
