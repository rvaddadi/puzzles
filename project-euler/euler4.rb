max_digits = 3
def is_palindrome(number)
  str = number.to_s
  str == str.reverse
end
max_factor = (9.to_s * max_digits).to_i
min_factor = max_factor / 10 + 1
palindrome = 0
max_factor.downto(min_factor) do |n1|
  n1.downto(min_factor) do |n2|
    m = n1 * n2
    palindrome = m if is_palindrome m and m > palindrome
  end
end
p palindrome

