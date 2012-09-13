class Integer
  def divisors
    divisors_under_sqrt = (1..Math.sqrt(self).to_i).select { |number| self % number == 0 }
    divisors_under_sqrt + divisors_under_sqrt.map { |number| self / number }
  end
end
number = 0
i = 1
while number.divisors.size < 500
  number += i
  i += 1
end
p number