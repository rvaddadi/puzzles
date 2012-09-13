limit = 10001
count = 6
prime = 13
n = prime
def is_prime(number)
  2.upto(Math.sqrt(number).to_i) { |n| return false if number % n == 0 }
  true
end
while count < limit
  n += 4
  if is_prime n
    count += 1
    prime = n
  end
  if count < limit
    n += 2
    if is_prime n
      count += 1
      prime = n
    end
  end
end
p prime

