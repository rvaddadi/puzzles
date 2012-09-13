number = 100
p ((1..number).reduce(:*)).to_s.split(//).map { |n| n.to_i }.reduce(:+)
