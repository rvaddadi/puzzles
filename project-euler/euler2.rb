fib1 = 0
fib2 = 1
sum = 0
while fib2 < 4000000
  sum += fib2 if fib2 % 2 == 0
  fib1, fib2 = fib2, fib1 + fib2
end
p sum

