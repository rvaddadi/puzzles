# With this program I learned something really nice!
# I initially used "str += number.to_s" on line 10. That would run forever.
# After solving the problem with another more complicated logic, I saw a code
# on the forum that made me change to "str << number.to_s" and now it runs on an eyeblink! :D

LIMIT = 1_000_000

str = "0"
number = 1

while str.size <= LIMIT
  str << number.to_s
  number += 1
end

p (0...7).inject(1) { |prod, exp| prod *= str[10 ** exp].to_i }
