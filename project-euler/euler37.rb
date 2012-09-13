require 'prime'

class Integer
  def truncatable_prime?
    return false unless self > 7
    self_last_index = self.to_s.size - 1
    (0..self_last_index).each do |i|
      return false unless self.to_s[i..self_last_index].to_i.prime? &&
          self.to_s[0..i].to_i.prime?
    end
    true
  end
end

sum = count_truncatable_primes = 0
Prime.each do |prime|
  if prime.truncatable_prime?
    sum += prime
    count_truncatable_primes += 1
    break if count_truncatable_primes == 11
  end
end

p sum