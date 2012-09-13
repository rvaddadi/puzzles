exp = 1000
p (2 ** exp).to_s.split(//).map { |n| n.to_i }.reduce(:+)
