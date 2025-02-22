require 'spec_helper'

describe Lbank do
  describe '#currency_rates' do
    subject { described_class.currency_rates(time) }

    let(:time) {}

    its(['USD']) { is_expected.to be > 0 }

    context 'when invalid time' do
      let(:time) { Time.now + 1.week }

      it 'raises error' do
        expect { subject }.to raise_error(Lbank::ResponseError, /No data/)
      end
    end
  end

  describe '#convert_currency' do
    it 'converts currency' do
      expect(subject.convert_currency(10, 'USD', 'EUR')).to be > 0
      expect(subject.convert_currency(10, 'EUR', 'LTL')).to eq 34.528

      date = Date.new(2012, 8, 4)

      expect(subject.convert_currency(10, 'EUR', 'LTL')).to eq 34.528
      expect(subject.convert_currency(1, 'USD', 'EUR', date).round(2)).to eq 0.82
      expect(subject.convert_currency(100, 'RUB', 'USD', date).round(2)).to eq 3.08
    end
  end
end
