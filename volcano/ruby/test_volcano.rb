require 'test/unit'
require_relative 'volcano'

class TestVolcano < Test::Unit::TestCase

  def test_case_1
    assert_equal 5, volcano(File.read('../test_cases/case-1.txt').to_s)
  end

  def test_case_2
    assert_equal 4, volcano(File.read('../test_cases/case-2.txt').to_s)
  end

end
