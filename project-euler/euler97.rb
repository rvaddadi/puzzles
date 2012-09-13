def modpow(base, pow, mod)
  (1..pow).inject(1) { |mult,x| (mult * base) % mod }
end

p (28433 * modpow(2, 7830457, 10**10) + 1) % 10**10
