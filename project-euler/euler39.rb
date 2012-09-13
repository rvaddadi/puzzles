# This program is sloooow!
# I was searching for a way to make it run faster
# and left it running. Then, after a few minutes, it finished!
# I thought it wouldn't terminate, but it did. So that's it for now :)

LIMIT = 1000

solutions = Hash.new(0)
(1..LIMIT).each do |a|
  (1..LIMIT).each do |b|
    (1..LIMIT).each do |c|
      if a < b && b < c && a + b + c <= LIMIT && a**2 + b**2 == c**2
        solutions[a + b + c] += 1
      end
    end
  end
end

p solutions.max_by { |key, value| value }[0]
