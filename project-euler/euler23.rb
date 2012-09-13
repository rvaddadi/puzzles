# This problem is tricky and showed how inneficient some features can be!
# At first I deleted elements from the not_sum_two_abundants array.
# But that was so slow I couldn't find the answer.
# So I searched the web and found this http://universequeen.org/archives/122
# And changed my approach. Instead of deleting the element, I changed it's value
# to 0. Now the program runs in 15s :D


class Integer
  @@cache_sum_divisors = {}
  def sum_divisors
    return @@cache_sum_divisors[self] if @@cache_sum_divisors.include? self
    @@cache_sum_divisors[self] = (1..Math.sqrt(self).to_i).select { |n| self % n == 0 }.inject { |sum, n| sum + n + if n != (self / n) then (self / n) else 0 end }
  end
  def abundant?
    self < self.sum_divisors
  end
end
limit = 28123
abundants = (1..limit).to_a.select { |n| n.abundant? }
not_sum_two_abundants = (1..limit).to_a
sum = 0
abundants.each_index do |i1|
  abundants[i1..-1].each_index do |i2|
    sum = abundants[i1] + abundants[i2]
    break if sum > limit
    not_sum_two_abundants[sum - 1] = 0
  end
end
p not_sum_two_abundants.reduce(:+)
