require 'lbank/version'
require 'lbank/memory_cache'
require 'open-uri'
require 'csv'
require 'active_support/time'

module Lbank

  BASE_CURRENCY = 'LTL'
  TIMEZONE      = 'Europe/Vilnius'
  SOURCE        = 'http://lbank.lt/exchange/Results.asp'

  module_function

  def cache
    @cache ||= MemoryCache.new
  end

  def currency_rates(time = nil)
    time      ||= Time.now
    bank_time = time.to_time.in_time_zone(TIMEZONE)
    date      = [ bank_time.year, bank_time.month, bank_time.day ]


    cache.fetch(cache_key(date)) do
      url   = "#{SOURCE}?Y=%i&M=%i&D=%i&S=csv" % date
      rates = {}

      data  = open(url).read

      CSV.parse(data).each do |row|
        rates[row[1]] = row[2].to_i / row[3].to_f
      end

      rates[BASE_CURRENCY] = 1.0
      rates
    end
  end

  def convert_currency(amount, from_currency, to_currency,  date = nil)
    rates     = self.currency_rates(date)

    from_rate = rates[from_currency.to_s]
    to_rate   = rates[to_currency.to_s]

    amount / from_rate * to_rate
  end

  def cache_key(date)
    "lbank-#{date.join('-')}"
  end
end
