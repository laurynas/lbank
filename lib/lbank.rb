require "lbank/version"
require 'open-uri'
require 'csv'

module Lbank

  BASE_CURRENCY = 'LTL'
  SOURCE        = 'http://lbank.lt/exchange/Results.asp'
  @@cache       = {}

  def self.currency_rates(date = nil)
    date  ||= Date.today

    if @@cache[date].nil?
      url   = "#{SOURCE}?Y=%i&M=%i&D=%i&S=csv" % [ date.year, date.month, date.day ]
      rates = {}

      data  = open(url).read

      CSV.parse(data).each do |row|
        rates[row[1]] = row[2].to_i / row[3].to_f
      end

      rates[BASE_CURRENCY] = 1.0

      @@cache[date] = rates
    end

    @@cache[date]
  end

  def self.convert_currency(amount, from_currency, to_currency,  date = nil)
    rates     = self.currency_rates(date)

    from_rate = rates[from_currency.to_s]
    to_rate   = rates[to_currency.to_s]

    amount / from_rate * to_rate
  end

end
