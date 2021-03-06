require 'spec_helper'

# First test case in
# http://olimpiada.ic.unicamp.br/pratique/programacao/nivel2/2012f2p2_banco:
#
# | Client | Arrival | Serving duration | Start | Finish | Waiting | Exceeded |
# |--------|---------|------------------|-------|--------|---------|----------|
# | 1      | 0       | 10               | 0     | 10     | 0       | No       |
# | 2      | 0       | 10               | 10    | 20     | 10      | No       |
# | 3      | 1       | 10               | 20    | 30     | 19      | No       |
# | 4      | 2       | 10               | 30    | 40     | 28      | Yes      |
# | 5      | 30      | 10               | 40    | 50     | 10      | No       |

describe Bank do
  subject(:bank) { Bank.new }

  let(:tellers) { 1 }
  let(:clients) {
    [
     Bank::Client.new(0,  10),
     Bank::Client.new(0,  10),
     Bank::Client.new(1,  10),
     Bank::Client.new(2,  10),
     Bank::Client.new(30, 10),
   ]
  }
  let(:waiting_durations) { [0, 10, 19, 28, 10] }
  let(:max_waiting_time) { 20 }

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
              .add_to_line(clients)
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

      context 'there are clients in line' do
        before { bank.add_to_line(clients) }

        it 'calculates waited time for each Client' do
          expect(
            subject.clients.map(&:waiting_duration)
          ).to match_array(waiting_durations)
        end
      end
    end
  end

  describe '#add_to_line' do
    subject { bank.add_to_line(clients) }

    context 'is closed' do
      it 'raises Bank::InvalidStateError' do
        expect(-> { subject }).to raise_error Bank::InvalidStateError
      end
    end

    context 'is open' do
      before { bank.open(tellers) }

      context 'multiple Clients' do
        it 'adds all Clients to line' do
          expect(subject.clients).to match_array(clients)
        end
      end

      context 'single Client' do
        subject { bank.add_to_line(client) }
        let(:client) { clients.first }

        it 'adds single Client to line' do
          expect(subject.clients).to match_array([client])
        end
      end
    end
  end

  describe '#clients_that_waited_more_than' do
    subject { bank.clients_that_waited_more_than(max_waiting_time) }

    context 'is open' do
      before { bank.open(tellers) }

      it 'raises Bank::InvalidStateError' do
        expect(-> { subject }).to raise_error Bank::InvalidStateError
      end
    end

    context 'is closed' do
      before do
        bank.open(tellers)
            .add_to_line(clients)
            .close
      end

      it 'returns quantity of clients that match condition' do
        expect(subject).to eq(1)
      end
    end
  end
end
