class Integer
  @@cache_sum_divisors = {}
  def sum_divisors
    return @@cache_sum_divisors[self] if @@cache_sum_divisors.include? self
    @@cache_sum_divisors[self] = (1..Math.sqrt(self).to_i).select { |n| self % n == 0 }.inject { |sum, n| sum + n + if n != (self / n) then (self / n) else 0 end }
  end
  def amicable?
    self != self.sum_divisors and self == self.sum_divisors.sum_divisors
  end
end
p (2...10000).select { |n| n.amicable? }.reduce(:+)
