class Solitaire

  JOKER_A = 53
  JOKER_B = 54

  def initialize(deck)
    throw ArgumentError.new if deck.sort != (1..54).to_a
    @deck = deck
  end

  def encrypt(message)
    # step 1
    sanitized_message = sanitize message

    # step 2
    keystream = keystream sanitized_message

    # step 3
    sanitized_message_numbers = to_numbers sanitized_message

    # step 4
    keystream_numbers = to_numbers keystream

    # step 5
    added_numbers = add_numbers sanitized_message_numbers, keystream_numbers

    # step 6
    to_letters added_numbers
  end

  def decrypt(message)
    # step 1
    keystream = keystream message

    # step 2
    message_numbers = to_numbers message

    # step 3
    keystream_numbers = to_numbers keystream

    # step 4
    subtracted_numbers = subtract_numbers message_numbers, keystream_numbers

    # step 5
    to_letters subtracted_numbers
  end

  private

    def sanitize(message)
      group(message
        .gsub(/[^a-z]/i, '')
        .upcase)
        .strip
    end

    def keystream(message)
      message_without_spaces = remove_spaces message

      keystream = ''

      # step 1 is keying the cards, but I prefer to
      # have the keying deck as a dependency, as the user might
      # prefer having it keyed in some particular way
      current_deck = @deck.dup

      until keystream.size == message_without_spaces.size

        # step 2
        current_deck = move_down current_deck, JOKER_A, 1

        # step 3
        current_deck = move_down current_deck, JOKER_B, 2

        # step 4
        current_deck = triple_cut current_deck, JOKER_A, JOKER_B

        # step 5
        current_deck = cut_bottom current_deck

        # step 6
        keystream << output_letter(current_deck)
      end

      sanitize keystream
    end

    def to_numbers(message)
      remove_spaces(
        message)
        .each_char
        .map { |char| char.ord - 'A'.ord.pred }
    end

    def add_numbers(numbers_1, numbers_2)
      map_numbers(numbers_1, numbers_2) { |a, b| ((a + b).pred % 26).succ }
    end

    def subtract_numbers(numbers_1, numbers_2)
      map_numbers(numbers_1, numbers_2) { |a, b| ((a - b).pred % 26).succ }
    end

    def to_letters(numbers)
      group(numbers
        .map { |number| (number + 'A'.ord.pred).chr }
        .join)
        .strip
    end

    def map_numbers(numbers_1, numbers_2, &block)
      numbers_1
        .zip(numbers_2)
        .map(&block)
    end

    def group(message)
      message
        .gsub(/.{1,5}/) { |section| section.ljust(5, 'X') + ' ' }
    end

    def remove_spaces(message)
      message.gsub(' ', '')
    end

    def move_down(deck, card, moves)
      current_deck = deck.dup

      old_index = current_deck.index card
      new_index = ((old_index + moves).pred % 53).succ

      current_deck.insert(new_index, current_deck.delete_at(old_index))
    end

    def triple_cut(deck, card_1, card_2)
      top_card_index, bottom_card_index = [deck.index(card_1), deck.index(card_2)].minmax

      deck[bottom_card_index.succ..-1].to_a          +
        deck[top_card_index..bottom_card_index].to_a +
        deck[0..top_card_index.pred].to_a
    end

    def cut_bottom(deck)
      bottom_card_value = deck.last

      deck[bottom_card_value..-2].to_a  +
        deck[0..bottom_card_value.pred].to_a +
        [bottom_card_value]
    end

    def output_letter(deck)
      output_card = deck[[deck.first, 53].min]

      if output_card < 53
        ('A'.ord.pred + (output_card % 26)).chr
      else
        ''
      end
    end
end
