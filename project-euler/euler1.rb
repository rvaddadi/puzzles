p (1...1000).find_all { |n| n % 3 == 0 or n % 5 == 0  } .reduce(:+)

