require 'ostruct'

class Poker

  CARDS = %w( 2 3 4 5 6 7 8 9 T J Q K A )
  SUITS = %w( D H S C )

  def calculate_winner(hand_1, hand_2)
    select_card = ->(parsed_hand, card_index) { parsed_hand.select { |hand| hand.card_index != card_index } }
    processes = [:royal_flush?, :straight_flush, :four_of_a_kind,
      :full_house, :flush, :straight, :three_of_a_kind,
      :two_pair, :one_pair, ->(*args){ true }]

    parsed_hand_1 = parse_hand hand_1
    parsed_hand_2 = parse_hand hand_2

    processes.each do |process|
      processed_hand_1 = process.to_proc[self, parsed_hand_1]
      processed_hand_2 = process.to_proc[self, parsed_hand_2]

      return 1 if   processed_hand_1 && ! processed_hand_2
      return 2 if ! processed_hand_1 &&   processed_hand_2

      if processed_hand_1 && processed_hand_2
        if processed_hand_1.respond_to? :<
          return 1 if processed_hand_1 > processed_hand_2
          return 2 if processed_hand_1 < processed_hand_2
        end
        return highest_card(select_card[parsed_hand_1, processed_hand_1]) > highest_card(select_card[parsed_hand_2, processed_hand_1]) ? 1 : 2
      end
    end
  end

  def royal_flush?(hand)
     flush(hand) && straight(hand) == CARDS.index('A')
  end

  def straight_flush(hand)
    straight(hand) if flush(hand)
  end

  def four_of_a_kind(hand)
    cards_counts = cards_counts(hand)
    cards_counts.last.card_index if cards_counts.map(&:count) == [1, 4]
  end

  def full_house(hand)
    cards_counts = cards_counts(hand)
    cards_counts.last.card_index if cards_counts.map(&:count) == [2, 3]
  end

  def flush(hand)
    hand[0].suit_index if hand.map(&:suit_index).all? { |suit_index| suit_index == hand[0].suit_index }
  end

  def straight(hand)
    cards = hand.sort_by(&:card_index)
    cards.last.card_index if cards.zip([nil] + cards)[1..-1].all? { |(card_0, card_1)| (card_0.card_index - card_1.card_index).abs == 1 }
  end

  def three_of_a_kind(hand)
    cards_counts = cards_counts(hand)
    cards_counts.last.card_index if cards_counts.map(&:count) == [1, 1, 3]
  end

  def two_pair(hand)
    cards_counts = cards_counts(hand)
    [cards_counts.last.card_index, cards_counts[-2].card_index].max if cards_counts.map(&:count) == [1, 2, 2]
  end

  def one_pair(hand)
    cards_counts = cards_counts(hand)
    cards_counts.last.card_index if cards_counts.last(2).map(&:count) == [1, 2]
  end

  def highest_card(hand)
    hand.map(&:card_index).max
  end

  def parse_hand(hand)
    hand
      .split(' ')
      .map { |card_suit|
        card, suit = card_suit.split('')
        OpenStruct.new(
          card:       card,
          suit:       suit,
          card_index: CARDS.index(card),
          suit_index: SUITS.index(suit)
        )
      }
  end

  def cards_counts(hand)
    hand
      .group_by(&:card)
      .map { |(_, ocurrencies)|
        OpenStruct.new(
          count:      ocurrencies.count,
          card_index: ocurrencies.first.card_index
        )
      }
      .sort_by(&:count)
  end
end
