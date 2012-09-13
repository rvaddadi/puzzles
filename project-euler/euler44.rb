# With this problem I learned a very special class!
# It's called Set, I saw it on igortice comment on page 5 of the forum.
# Set lookup is soooo much faster, with it it's possible to implement my original
# idea to solve this problem! Which was brute force, anyway, but much more elegant:

#require 'set'
#pentagonals = (1..3000).map { |n| n*(3*n-1)/2 }.to_set
#p pentagonals.to_a.combination(2).select { |a,b|
#  pentagonals.include?(a+b) && pentagonals.include?((a-b).abs)
#}.map { |a,b| (a-b).abs }.min


# Test for pentagonal numbers
# http://en.wikipedia.org/wiki/Pentagonal_number

class Integer
  def pentagonal?
    (Math.sqrt(24 * self + 1) + 1) / 6 % 1 == 0
  end
end

def pentagonal(n)
  n * (3 * n - 1) / 2
end

(2..Float::INFINITY).each do |i|
  pi = pentagonal(i)
  (i - 1).downto(1) do |j|
    pj = pentagonal(j)
    if (pi - pj).pentagonal? && (pi + pj).pentagonal?
      p pi - pj
      exit
    end
  end
end
