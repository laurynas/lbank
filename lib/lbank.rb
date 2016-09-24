require 'lbank/version'
require 'open-uri'
require 'csv'
require 'active_support/time'

module Lbank

  BASE_CURRENCY = 'LTL'
  TIMEZONE      = 'Europe/Vilnius'
  SOURCE        = 'http://lbank.lt/exchange/Results.asp'

  @@cache       = {}

  def self.currency_rates(time = nil)
    time      ||= Time.now
    bank_time = time.to_time.in_time_zone(TIMEZONE)
    date      = [ bank_time.year, bank_time.month, bank_time.day ]

    if @@cache[date].nil?
      url   = "#{SOURCE}?Y=%i&M=%i&D=%i&S=csv" % date
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
