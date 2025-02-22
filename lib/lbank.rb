require 'lbank/version'
require 'lbank/memory_cache'
require 'lbank/errors'
require 'active_support/time'
require 'faraday'
require 'faraday_middleware'
require 'bigdecimal'

module Lbank
  RATE_TYPE = 'LT'
  TIMEZONE = 'Europe/Vilnius'
  URL = 'http://www.lb.lt/webservices/FxRates/FxRates.asmx/getFxRates'
  LTL = 'LTL'
  LTL_RATE = BigDecimal('3.45280')

  module_function

  def cache
    @cache ||= MemoryCache.new
  end

  def cache=(store)
    @cache = store
  end

  def currency_rates(time = nil)
    time ||= Time.now
    bank_time = time.to_time.in_time_zone(TIMEZONE)
    date = bank_time.strftime('%Y-%m-%d')

    cache.fetch(cache_key(date)) do
      response = connection.post(URL, tp: RATE_TYPE, dt: date)
      error = response.body['FxRates']['OprlErr']

      raise ResponseError.new(error['Desc']) if error

      fx_rates = response.body['FxRates']['FxRate']

      rates = { fx_rates[0]['CcyAmt'][0]['Ccy'] => 1 }
      rates[LTL] ||= LTL_RATE

      fx_rates.each_with_object(rates) do |rate, result|
        base, foreign = rate['CcyAmt']
        result[foreign['Ccy']] = BigDecimal(foreign['Amt']) / BigDecimal(base['Amt'])
      end
    end
  end

  def convert_currency(amount, from_currency, to_currency, time = nil)
    rates = currency_rates(time)
    from_rate = rates[from_currency.to_s]
    to_rate = rates[to_currency.to_s]

    amount / from_rate * to_rate
  end

  def cache_key(date)
    "lbank-#{date}"
  end

  def connection
    @connection ||= Faraday.new do |builder|
      builder.request :url_encoded
      builder.response :raise_error
      builder.response :xml, content_type: /\bxml$/
      builder.adapter Faraday.default_adapter
    end
  end
end
