#searching until 1000000 works, but there are smarter ways to limit this
#sum to be sure that you got the right answer. This one runs in 56s.
# Case closed!

class Integer
  def sum_power_digits(power)
    self.to_s.split(//).map { |digit| digit.to_i ** power }.reduce(:+)
  end
end

p (2..1000000).to_a.select { |number| number == number.sum_power_digits(5) }.reduce(:+)
