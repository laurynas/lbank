require 'spec_helper'

describe Lbank do

  it "should return currency rates" do
    currency_rates = subject.currency_rates

    currency_rates['USD'].should be > 0
  end

  it "should convert currency" do
    subject.convert_currency(10, 'LTL', 'EUR').should be > 0

    date = Date.new(2012, 8, 4)

    subject.convert_currency(10, 'LTL', 'EUR', date).round(2).should == 2.90
    subject.convert_currency(10, 'LTL', 'USD', date).round(2).should == 3.55
    subject.convert_currency(100, 'RUB', 'LTL', date).round(2).should == 8.68
    subject.convert_currency(100, 'RUB', 'USD', date).round(2).should == 3.08
  end

end