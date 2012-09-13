min = 2
max = 100
elements = []
(min..max).each { |a| (min..max).each { |b| elements << a ** b } }
p elements.uniq.size
