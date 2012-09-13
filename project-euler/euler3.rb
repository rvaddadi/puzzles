#this one I actually tried to solve in many different ways
# that were sooo slow that never got to finish with the big
# value the challenge give.
# so I read about ideas on it. After a few days I wrote this,
# which is I could remember and understand from what a read.
number = 600851475143
max_factor = 2
n = 2
while number > 1
  if number % n == 0
    max_factor = n
    number /= n
  else
    n += 1
  end
end
p max_factor

