#this isn't the best code of my life. But it solved the problem in 18s on my
#machine. That's good enough :P

number = 1000
(1...number).each do |a|
  (1...number).each do |b|
    (1...number).each do |c|
      if a + b + c == number and a < b and b < c and a ** 2 + b ** 2 == c ** 2
        p a * b * c
        exit
      end
    end
  end
end

