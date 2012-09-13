max_num = 100
sum_squares = (1..max_num).map {|n| n ** 2 }.reduce(:+)
square_sum = (1..max_num).reduce(:+) ** 2
p square_sum - sum_squares

