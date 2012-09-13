class Integer

  ROMAN_NUMERALS = {
    1000 => 'M',
    900  => 'CM',
    500  => 'D',
    400  => 'CD',
    100  => 'C',
    90   => 'XC',
    50   => 'L',
    40   => 'XL',
    10   => 'X',
    9    => 'IX',
    5    => 'V',
    4    => 'IV',
    1    => 'I',
  }

  def to_roman

    ''.tap do |answer|

      n = self

      until n <= 0
        # only works in Ruby 1.9, in which the order of the hash is guaranteed
        ROMAN_NUMERALS.each_pair do |number, roman|
          if n >= number
            n -= number
            answer << roman
            break
          end
        end
      end
    end
  end

end

class String

  ROMAN_NUMERALS = {
    'CM' => 900,
    'CD' => 400,
    'XC' => 90,
    'XL' => 40,
    'IX' => 9,
    'IV' => 4,
    'M'  => 1000,
    'D'  => 500,
    'C'  => 100,
    'L'  => 50,
    'X'  => 10,
    'V'  => 5,
    'I'  => 1,
  }

  def from_roman
    answer = 0

    string = self.dup

    until string.empty?
      ROMAN_NUMERALS.each_pair do |roman, number|

        size = roman.size

        if string[0...size] == roman
          string =  string[size..-1]
          answer += number
          break
        end
      end
    end

    answer
  end

end
