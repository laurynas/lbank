require 'spec_helper'

describe Lbank do
  describe '#currency_rates' do
    subject { described_class.currency_rates }

    its(['USD']) { is_expected.to be > 0 }
  end

  describe '#convert_currency' do
    it 'converts currency' do
      expect(subject.convert_currency(10, 'LTL', 'EUR')).to be > 0

      date = Date.new(2012, 8, 4)

      expect(round(subject.convert_currency(10, 'LTL', 'EUR', date))).to eq 2.90
      expect(round(subject.convert_currency(10, 'LTL', 'USD', date))).to eq 3.55
      expect(round(subject.convert_currency(100, 'RUB', 'LTL', date))).to eq 8.68
      expect(round(subject.convert_currency(100, 'RUB', 'USD', date))).to eq 3.08
    end
  end

  private

  def round(number, precision = 2)
    ("%.#{precision}f" % number).to_f
  end
end
