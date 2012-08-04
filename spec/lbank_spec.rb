require 'spec_helper'

describe Lbank do

  it "should return currency rates" do
    currency_rates = subject.currency_rates

    currency_rates['USD'].should be > 0
  end

  it "should convert currency" do
    subject.convert_currency(10, 'LTL', 'EUR').should be > 0

    date = Date.new(2012, 8, 4)

    round(subject.convert_currency(10, 'LTL', 'EUR', date)).should == 2.90
    round(subject.convert_currency(10, 'LTL', 'USD', date)).should == 3.55
    round(subject.convert_currency(100, 'RUB', 'LTL', date)).should == 8.68
    round(subject.convert_currency(100, 'RUB', 'USD', date)).should == 3.08
  end

  private

  def round(number, precision = 2)
    ("%.#{precision}f" % number).to_f
  end

end