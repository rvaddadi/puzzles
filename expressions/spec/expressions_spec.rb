require 'spec_helper'

describe '#resolve' do
  subject { resolve expression }

  describe 'empty expression' do
    let(:expression) { '' }

    it 'raises ArgumentError' do
      expect { subject }.to raise_error ArgumentError
    end
  end

  describe 'blank expression' do
    let(:expression) { "  \t \n \r\n " }

    it 'raises ArgumentError' do
      expect { subject }.to raise_error ArgumentError
    end
  end

  describe 'number' do
    let(:expression) { '42' }

    it 'returns the number' do
      expect(subject).to eq(42)
    end
  end

  describe 'sum' do
    let(:expression) { '42 + 30' }

    it 'returns the sum' do
      expect(subject).to eq(72)
    end
  end

  describe 'subtraction' do
    let(:expression) { '42 - 30' }

    it 'returns the subtraction' do
      expect(subject).to eq(12)
    end
  end

  describe 'multiplication' do
    let(:expression) { '42 * 3' }

    it 'returns the multiplication' do
      expect(subject).to eq(126)
    end
  end

  describe 'division' do
    let(:expression) { '42 / 2' }

    it 'returns the division' do
      expect(subject).to eq(21)
    end
  end

  describe 'operations precedence' do
    describe 'sum and subtraction' do
      let(:expression) { '10 - 5 + 5 - 3' }

      specify 'have the same precedence' do
        expect(subject).to eq(7)
      end
    end

    describe 'multiplication and division' do
      let(:expression) { '10 / 5 * 5 / 2' }

      specify 'have the same precedence' do
        expect(subject).to eq(5)
      end
    end

    describe 'sum and multiplication' do
      let(:expression) { '5 + 2 * 10' }

      specify 'multiplication happens first' do
        expect(subject).to eq(25)
      end
    end
  end

  describe 'brackets' do
    let(:expression) { '(5 + 2) * 10' }

    it 'changes precedence of operations' do
      expect(subject).to eq(70)
    end
  end
end
