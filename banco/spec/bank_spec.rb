require 'spec_helper'

describe Bank do
  subject(:bank) { Bank.new }

  let(:tellers) { 1 }

  describe '#open' do
    subject { bank.open(tellers) }

    context 'bank is closed' do
      it 'returns the bank itself' do
        expect(subject).to eq(bank)
      end

      it 'sets the quantity of tellers' do
        expect(subject.tellers).to eq(tellers)
      end
    end

    context 'bank is already open' do
      it 'raises Bank::AlreadyOpen' do
        expect(-> { subject.open(tellers) }).to raise_error Bank::AlreadyOpen
      end
    end
  end

  describe '#open?' do
    subject { bank.open? }

    context 'bank is closed' do
      it 'returns true' do
        expect(subject).to be_false
      end
    end

    context 'bank is open' do
      before { bank.open(tellers) }

      it 'returns false' do
        expect(subject).to be_true
      end
    end
  end

  describe '#close' do
    subject { bank.open(tellers).close }


  end
end
