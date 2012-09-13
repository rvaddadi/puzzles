require 'mathn'

class Integer
  def digits
    to_s.split(//).map(&:to_i).sort
  end
end

found = 0
(1000..9999).each do |n1|
  next unless Prime.prime? n1
  (2..8999).each do |increment|
    break if (n2 = n1 + increment) > 9999
    break if (n3 = n2 + increment) > 9999
    n1_digits = n1.digits
    next  if n1_digits != n2.digits || n1_digits != n3.digits || ! Prime.prime?(n2) || ! Prime.prime?(n3) 
    found += 1
    p n1.to_s + n2.to_s + n3.to_s
    exit if found == 2
  end
end
