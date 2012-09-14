require 'test/unit'
require_relative 'diamond'

class TestDiamond < Test::Unit::TestCase

  def setup
    @diamond = Diamond.new
  end

  def test_E
    assert_match File.read('result_E.txt').to_s, @diamond.draw('E')
  end

  def test_C
    assert_match File.read('result_C.txt').to_s, @diamond.draw('C')
  end

end
