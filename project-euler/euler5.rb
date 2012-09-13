max_number = 20
def factor(number)
  factors = []
  n = 2
  while number > 1
    if number % n == 0
      factors.push n
      number /= n
    else
      n += 1
    end
  end
  factors
end
def quantity(numbers)
  quantities = {}
  numbers.each { |n| if quantities[n] then quantities[n] += 1 else quantities[n] = 1 end }
  quantities
end
factors = {}
(1..max_number).each do |number|
  quantities = quantity(factor(number))
  quantities.each do |factor, quantity|
    if not factors[factor]
      factors[factor] = quantity
    elsif factors[factor] < quantity
      factors[factor] = quantity
    end
  end
end
min_multiple = 1
factors.each { |factor, quantity| min_multiple *= factor ** quantity }
p min_multiple

