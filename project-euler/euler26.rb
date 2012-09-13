# This one was so nice to solve!
# I made an attempt a long time ago
# and only now I've been able to solve it!

# The main reason is because, after trying brute
# force in many ways and being frustrated many times,
# I found this http://www.lrz.de/~hr/numb/period.html

# In the end, all that got me going was this phrase:

#   For denominator q, the period length is the smallest
#   k such that q divides 10k-1. E.g. for 41, the period length
#   is 5 because 41 divides 99999.

require 'mathn'

class Rational
  def period_length
    q = self.denominator
    k = 0
    loop do
      ten_power = (10**k - 1)
      return k if ten_power > q && ten_power % q == 0
      k += 1
    end
  end
end

periods_length = {}
(7..1000).select(&:prime?).each { |denominator| periods_length[denominator] = (1/denominator).period_length }

p periods_length.max_by { |c| c[1] }[0]