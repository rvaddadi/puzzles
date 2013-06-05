require 'spec_helper'
require 'stringio'

describe 'test cases from '\
         'http://olimpiada.ic.unicamp.br/pratique/'\
         'programacao/nivel2/2012f2p2_banco' do

  let(:stdin)  { ARGF }
  let(:stdout) { STDOUT }

  describe 'case 1' do
    specify 'correct outputs' do
      expect(stdin).to receive(:gets).and_return(
        '1 5',
        '0 10',
        '0 10',
        '1 10',
        '2 10',
        '30 10'
      )
      expect(stdout).to receive(:puts).with(1)

      load 'bin/bank'
    end
  end

  describe 'case 2' do
    specify 'correct outputs' do
      expect(stdin).to receive(:gets).and_return(
        '3 16',
        '0 10',
        '0 10',
        '0 10',
        '3 10',
        '5 10',
        '7 10',
        '11 10',
        '13 10',
        '14 10',
        '15 10',
        '16 10',
        '17 10',
        '18 3',
        '19 10',
        '20 10',
        '23 3'
      )
      expect(stdout).to receive(:puts).with(2)

      load 'bin/bank'
    end
  end
end
