require 'test/unit'
require 'ostruct'

require_relative '../lib/poker'

class PokerTest < Test::Unit::TestCase

  def setup
    @poker = Poker.new
  end

  def test_cards_counts
    assert_equal(
      [
        OpenStruct.new(count: 2, card_index: Poker::CARDS.index('9')),
        OpenStruct.new(count: 3, card_index: Poker::CARDS.index('T'))
      ],
      @poker.cards_counts(@poker.parse_hand('TD TS TH 9C 9H'))
    )
  end

  def test_royal_flush
    assert @poker.royal_flush?(@poker.parse_hand('TD JD QD KD AD'))
  end

  def test_non_royal_flush
    assert ! @poker.royal_flush?(@poker.parse_hand('TD JH QD KD AD'))
  end

  def test_straight_flush
    assert_equal Poker::CARDS.index('K'), @poker.straight_flush(@poker.parse_hand('9D TD JD QD KD'))
  end

  def test_non_straight_flush
    assert_equal nil, @poker.straight_flush(@poker.parse_hand('8D TD JD QD KD'))
  end

  def test_four_of_a_kind
    assert_equal Poker::CARDS.index('9'), @poker.four_of_a_kind(@poker.parse_hand('9H 9D 9S 9C KD'))
  end

  def test_non_four_of_a_kind
    assert_equal nil, @poker.four_of_a_kind(@poker.parse_hand('8D TD JD QD KD'))
  end

  def test_full_house
    assert_equal Poker::CARDS.index('9'), @poker.full_house(@poker.parse_hand('9H 9D 9S TC TD'))
  end

  def test_non_full_house
    assert_equal nil, @poker.full_house(@poker.parse_hand('8D TD JD QD KD'))
  end

  def test_flush
    assert_equal Poker::SUITS.index('D'), @poker.flush(@poker.parse_hand('TD 9D QD KD AD'))
  end

  def test_non_flush
    assert_equal nil, @poker.flush(@poker.parse_hand('TH 9D QD KD AD'))
  end

  def test_straight
    assert_equal Poker::CARDS.index('K'), @poker.straight(@poker.parse_hand('9C TH JH QD KD'))
  end

  def test_non_straight
    assert_equal nil, @poker.straight(@poker.parse_hand('TH 9C QH KD AD'))
  end

  def test_three_of_a_kind
    assert_equal Poker::CARDS.index('9'), @poker.three_of_a_kind(@poker.parse_hand('9H 9D 9S 8C KD'))
  end

  def test_non_three_of_a_kind
    assert_equal nil, @poker.three_of_a_kind(@poker.parse_hand('8D TD JD QD KD'))
  end

  def test_two_pair
    assert_equal Poker::CARDS.index('9'), @poker.two_pair(@poker.parse_hand('9H 9D 8S 8C KD'))
  end

  def test_non_two_pair
    assert_equal nil, @poker.two_pair(@poker.parse_hand('8D TD JD QD KD'))
  end

  def test_one_pair
    assert_equal Poker::CARDS.index('9'), @poker.one_pair(@poker.parse_hand('9H 9D 8S TC KD'))
  end

  def test_non_one_pair
    assert_equal nil, @poker.one_pair(@poker.parse_hand('8D TD JD QD KD'))
  end

  def test_highest_card
    assert_equal Poker::CARDS.index('A'), @poker.highest_card(@poker.parse_hand('AD TD QD 6D 2D'))
  end

  def test_case_1
    assert_equal 2, @poker.calculate_winner('5H 5C 6S 7S KD', '2C 3S 8S 8D TD')
  end

  def test_case_2
    assert_equal 1, @poker.calculate_winner('5D 8C 9S JS AC', '2C 5C 7D 8S QH')
  end

  def test_case_3
    assert_equal 2, @poker.calculate_winner('2D 9C AS AH AC', '3D 6D 7D TD QD')
  end

  def test_case_4
    assert_equal 1, @poker.calculate_winner('4D 6S 9H QH QC', '3D 6D 7H QD QS')
  end

  def test_case_5
    assert_equal 1, @poker.calculate_winner('2H 2D 4C 4D 4S', '3C 3D 3S 9S 9D')
  end
end
