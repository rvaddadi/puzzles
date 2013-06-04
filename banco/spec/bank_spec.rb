require 'spec_helper'

describe Bank do
  subject(:bank) { Bank.new }

  let(:tellers) { 1 }

  describe '#initialize' do
    it 'sets the state of the Bank to closed' do
      expect(subject.state).to eq(:closed)
    end

    it 'sets the quantity of tellers to zero' do
      expect(subject.tellers).to be_zero
    end
  end

  describe '#open' do
    subject { bank.open(tellers) }

    context 'Bank is closed' do
      it 'returns the Bank itself' do
        expect(subject).to eq(bank)
      end

      it 'sets the state of the Bank to open' do
        expect(subject.state).to eq(:open)
      end

      it 'sets the quantity of tellers' do
        expect(subject.tellers).to eq(tellers)
      end
    end

    context 'Bank is open' do
      it 'raises Bank::InvalidStateError' do
        expect(
          -> { subject.open(tellers) }
        ).to raise_error Bank::InvalidStateError
      end
    end
  end

  describe '#open?' do
    subject { bank.open? }

    context 'Bank is closed' do
      it 'returns true' do
        expect(subject).to be_false
      end
    end

    context 'Bank is open' do
      before { bank.open(tellers) }

      it 'returns false' do
        expect(subject).to be_true
      end
    end
  end

  describe '#close' do
    subject { bank.close }

    context 'Bank is closed' do
      it 'raises Bank::InvalidStateError' do
        expect(-> { subject }).to raise_error Bank::InvalidStateError
      end
    end

    context 'Bank is open' do
      before { bank.open(tellers) }

      it 'returns the Bank itself' do
        expect(subject).to eq(bank)
      end

      it 'sets the state of the Bank to closed' do
        expect(subject.state).to eq(:closed)
      end
    end
  end
end
