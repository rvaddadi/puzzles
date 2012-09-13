require 'test/unit'

class TestHanoi < Test::Unit::TestCase

  CASES = {
    'input00.txt' => 'output00.txt',
    'input01.txt' => 'output01.txt'
  }

  def test_cases
    CASES.each_pair do |input, output|
      assert_equal `ruby hanoi.rb < #{ input }`, File.read(output).to_s
    end
  end

end
