require 'mathn'

digits = [9, 8, 7, 6, 5, 4, 3, 2, 1]

until digits.empty?
  digits.permutation.each do |permutation|
    number = permutation.join.to_i
    if number.prime?
      p number
      exit
    end
  end
  digits.shift
end