# again, just guessed a upper bound that worked

class Integer
  @@factorial_cache = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]
  def factorial_digits_sum
    self.to_s.split(//).inject(0) { |sum, n| sum += @@factorial_cache[n.to_i] }
  end
end
p (3..100000).to_a.select { |n| n == n.factorial_digits_sum } .reduce(:+)
