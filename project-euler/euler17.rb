class Integer
  ENGLISH_NUMBERS = {
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  def to_english
    return ENGLISH_NUMBERS[self] if ENGLISH_NUMBERS.include? self
    if self < 100
      unit = self % 10
      return (self - unit).to_english + unit.to_english
    else
      dozen = self % 100
      return ((self - dozen) / 100).to_english + "hundred" + if dozen != 0 then "and" + dozen.to_english else "" end
    end
  end
end

p (1...1000).map { |n| n.to_english.size} .reduce(:+) + "onethousand".size
