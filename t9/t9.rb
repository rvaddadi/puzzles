class T9

  def initialize(dictionary = {
      'A' => '2',
      'B' => '22',
      'C' => '222',
      'D' => '3',
      'E' => '33',
      'F' => '333',
      'G' => '4',
      'H' => '44',
      'I' => '444',
      'J' => '5',
      'K' => '55',
      'L' => '555',
      'M' => '6',
      'N' => '66',
      'O' => '666',
      'P' => '7',
      'Q' => '77',
      'R' => '777',
      'S' => '7777',
      'T' => '8',
      'U' => '88',
      'V' => '888',
      'W' => '9',
      'X' => '99',
      'Y' => '999',
      'Z' => '9999',
      ' ' => '0',
    })
    @dictionary        = dictionary
    @invert_dictionary = dictionary.invert
  end

  def to_t9(message)
    message
      .each_char
      .map { |char| @dictionary[char.upcase] }
      .reduce('') do |result, char|
        result << '_' if result[-1] == char[0]
        result << char
      end
  end

  def from_t9(message)
    message
      .each_char
      .reduce([]) { |chars, char|

        if char == '_'
          chars << ''
        elsif chars.last.nil? || chars.last[-1] != char
          chars << char
        else
          chars.last << char
        end

        chars
      }
      .map { |char| @invert_dictionary[char] }
      .join
  end
end
