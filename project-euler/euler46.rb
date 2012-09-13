require 'prime'

number = 1
primes = [2]

loop do
  number += 2
  if Prime.prime? number
    primes << number
  else
    break if -> do
      primes.each do |prime|
        (1...number).each do |x|
          result = prime + 2 * x**2
          return false if result == number
          break        if result > number
        end
      end
    end.call
  end
end

p number
