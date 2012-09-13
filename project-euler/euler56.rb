max_sum = 0

(1...100).each do |a|
  (1...100).each do |b|
    number = a**b
    sum = number.to_s.split(//).map(&:to_i).reduce(:+)
    max_sum = sum if sum > max_sum
  end
end

p max_sum
