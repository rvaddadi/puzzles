# there's a study of this problem in this project
# It's a html that simulates the board.
# Plying it I inferred the formula used in this code
# I also checked the formula
# found here http://en.wikipedia.org/wiki/Triangular_number
# about triangular numbers

class Integer
  def triangular?
    double = self * 2
    double_sqrt = Math.sqrt double
    double_sqrt.ceil != double_sqrt.floor and double == double_sqrt.ceil * double_sqrt.floor
  end
end

limit = 100_000
1.upto(limit) do |n|
  solution = n * (n + 2)
  next unless solution.triangular?
  p [n, solution].join ","
end
