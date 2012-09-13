require 'test/unit'
require_relative 'roman'

class TestRoman < Test::Unit::TestCase

  def test_to_roman_simple_values
    assert_equal 'I', 1   .to_roman
    assert_equal 'V', 5   .to_roman
    assert_equal 'X', 10  .to_roman
    assert_equal 'L', 50  .to_roman
    assert_equal 'C', 100 .to_roman
    assert_equal 'D', 500 .to_roman
    assert_equal 'M', 1000.to_roman
  end

  def test_to_roman_repetitions
    assert_equal 'II' ,  2 .to_roman
    assert_equal 'III',  3 .to_roman
    assert_equal 'XX' ,  20.to_roman
  end

  def test_to_roman_4_90
    assert_equal 'IV', 4 .to_roman
    assert_equal 'XC', 90.to_roman
  end

  def test_from_roman_simple_values
    assert_equal 1   , 'I'.from_roman
    assert_equal 5   , 'V'.from_roman
    assert_equal 10  , 'X'.from_roman
    assert_equal 50  , 'L'.from_roman
    assert_equal 100 , 'C'.from_roman
    assert_equal 500 , 'D'.from_roman
    assert_equal 1000, 'M'.from_roman
  end

  def test_from_roman_repetitions
    assert_equal 2 , 'II' .from_roman
    assert_equal 3 , 'III'.from_roman
    assert_equal 20, 'XX' .from_roman
  end

  def test_from_roman_4_90
    assert_equal 4 , 'IV'.from_roman
    assert_equal 90, 'XC'.from_roman
  end
end
