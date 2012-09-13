require 'prime'
max = {product: 0, primes_count: 0}
(-999..999).each do |a|
  (-999..999).each do |b|
    if b.abs > max[:primes_count]
      n = 0
      n += 1 while Prime.prime? n ** 2 + a * n + b
      max = {product: a * b, primes_count: n} if n > max[:primes_count]
    end
  end
end

p max[:product]
