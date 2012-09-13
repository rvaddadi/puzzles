require 'mathn'

QUANTITY            = 4
n                   = 2
consecutive_numbers = []
prime_factors       = []

loop do
  n              += 1
  n_prime_factors = n.prime_division
  if n_prime_factors.size == QUANTITY && (n_prime_factors & prime_factors).empty?
    consecutive_numbers << n
    prime_factors       += n_prime_factors
  else
    consecutive_numbers = []
    prime_factors       = []
  end

  break if consecutive_numbers.size == QUANTITY
end

p consecutive_numbers.first
