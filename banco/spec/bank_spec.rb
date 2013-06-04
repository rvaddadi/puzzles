require 'spec_helper'

describe Bank do
  subject(:bank) { Bank.new }

  let(:tellers) { 1 }
  let(:clients) {
    [
     Bank::Client.new(arrival: 1,  service_duration: 5 ),
     Bank::Client.new(arrival: 0,  service_duration: 10),
     Bank::Client.new(arrival: 0,  service_duration: 10),
     Bank::Client.new(arrival: 1,  service_duration: 10),
     Bank::Client.new(arrival: 2,  service_duration: 10),
     Bank::Client.new(arrival: 30, service_duration: 10),
   ]
  }

  describe '#initialize' do
    it 'sets the state to closed' do
      expect(subject.state).to eq(:closed)
    end

    it 'sets the quantity of tellers to zero' do
      expect(subject.tellers).to be_zero
    end

    it 'starts the Clients with empty Array' do
      expect(subject.clients).to match_array([])
    end
  end

  describe '#open' do
    subject { bank.open(tellers) }

    context 'is closed' do
      it 'returns the Bank itself' do
        expect(subject).to eq(bank)
      end

      it 'sets the state to open' do
        expect(subject.state).to eq(:open)
      end

      it 'sets the quantity of tellers' do
        expect(subject.tellers).to eq(tellers)
      end

      context 'has Clients' do
        before do
          bank.open(tellers)
              .add_clients_to_line(clients)
              .close
        end

        it 'empties the Clients Array' do
          expect(subject.clients).to match_array([])
        end
      end
    end

    context 'is open' do
      it 'raises Bank::InvalidStateError' do
        expect(
          -> { subject.open(tellers) }
        ).to raise_error Bank::InvalidStateError
      end
    end
  end

  describe '#open?' do
    subject { bank.open? }

    context 'is closed' do
      it 'returns true' do
        expect(subject).to be_false
      end
    end

    context 'is open' do
      before { bank.open(tellers) }

      it 'returns false' do
        expect(subject).to be_true
      end
    end
  end

  describe '#close' do
    subject { bank.close }

    context 'is closed' do
      it 'raises Bank::InvalidStateError' do
        expect(-> { subject }).to raise_error Bank::InvalidStateError
      end
    end

    context 'is open' do
      before { bank.open(tellers) }

      it 'returns the Bank itself' do
        expect(subject).to eq(bank)
      end

      it 'sets the state to closed' do
        expect(subject.state).to eq(:closed)
      end
    end
  end

  describe '#add_clients_to_line' do
    subject { bank.add_clients_to_line(clients) }

    context 'is closed' do
      it 'raises Bank::InvalidStateError' do
        expect(-> { subject }).to raise_error Bank::InvalidStateError
      end
    end

    context 'is open' do
      before { bank.open(tellers) }

      it 'adds clients to line' do
        expect(subject.clients).to match_array(clients)
      end
    end
  end
end
