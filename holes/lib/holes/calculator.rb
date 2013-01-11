module Holes

  class Calculator

    LETTERS = Hash.new(0).merge({
      'a' => 1, 'b' => 1, 'd' => 1, 'e' => 1, 'g' => 2, 'o' => 1, 'p' => 1,
      'q' => 1,

      'A' => 1, 'B' => 2, 'D' => 1, 'O' => 1, 'P' => 1, 'Q' => 1, 'R' => 1,
    })

    def calculate(string)
      string
        .each_char
        .map { |letter| LETTERS[letter] }
        .reduce(:+)
    end
  end
end
