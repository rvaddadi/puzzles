#this one takes some time to complete. I got the right answer in 45s

limit = 2000000
prime = 5
sum = 5
def is_prime?(number)
  2.upto(Math.sqrt(number).to_i) { |n| return false if number % n == 0 }
  true
end
while prime < limit
  sum += prime if is_prime? prime
  prime += 2
  if prime < limit
    sum += prime if is_prime? prime
    prime += 4
  end
end
p sum