#this is a total mess :P

require 'prime'
circular_primes = 0
primes = []
Prime.instance.each(1_000_000) { |prime| primes << prime }
p primes.map { |prime| prime.to_s }.select { |prime|
  prime_arr = prime.split(//)
  prime.size == 1 or not prime.index(/[024568]/) and (1...prime.size).drop_while { primes.include? prime_arr.rotate!.join.to_i } .empty?
} .size