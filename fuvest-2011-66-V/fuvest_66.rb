require 'mathn'

a_set = (11..22).to_a
b_set = (43..51).to_a

all_cases = a_set.size * b_set.size
interest_cases = 0
a_set.each do |a|
  b_set.each do |b|
    interest_cases += 1 if (a/b).to_s == "#{a}/#{b}" && b.even?
  end
end

p interest_cases/all_cases
