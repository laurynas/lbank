require 'spec_helper'

describe Lbank do
  describe '#currency_rates' do
    subject { described_class.currency_rates }

    its(['USD']) { is_expected.to be > 0 }
  end

  describe '#convert_currency' do
    it 'converts currency' do
      expect(subject.convert_currency(10, 'USD', 'EUR')).to be > 0
      expect(subject.convert_currency(10, 'EUR', 'LTL')).to eq 34.528

      date = Date.new(2012, 8, 4)

      expect(subject.convert_currency(10, 'EUR', 'LTL')).to eq 34.528
      expect(round(subject.convert_currency(1, 'USD', 'EUR', date))).to eq 0.82
      expect(round(subject.convert_currency(100, 'RUB', 'USD', date))).to eq 3.08
    end
  end

  private

  def round(number, precision = 2)
    ("%.#{precision}f" % number).to_f
  end
end
