require 'spec_helper'

describe Lbank do
  let(:date) { Date.new(2012, 8, 4) }

  describe '#currency_rates' do
    subject { described_class.currency_rates(date) }

    its(['USD']) { is_expected.to be > 0 }

    context 'when invalid time' do
      let(:date) { Time.now + 1.week }

      it 'raises error' do
        expect { subject }.to raise_error(Lbank::ResponseError, /No data/)
      end
    end
  end

  describe '#convert_currency' do
    it 'converts currency' do
      expect(subject.convert_currency(10, 'EUR', 'LTL', date).round(2)).to eq 34.53
      expect(subject.convert_currency(1, 'USD', 'EUR', date).round(2)).to eq 0.82
      expect(subject.convert_currency(100, 'RUB', 'USD', date).round(2)).to eq 3.08
    end
  end
end
