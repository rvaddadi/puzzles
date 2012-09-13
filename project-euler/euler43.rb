class Integer
  def divisible_by?(n)
    self % n == 0
  end
end

sum = 0
(0..9).to_a.permutation do |d|
  next if d.first == 0
  sum += d.join.to_i if  "#{d[1]}#{d[2]}#{d[3]}".to_i.divisible_by?(2)  &&
                         "#{d[2]}#{d[3]}#{d[4]}".to_i.divisible_by?(3)  &&
                         "#{d[3]}#{d[4]}#{d[5]}".to_i.divisible_by?(5)  &&
                         "#{d[4]}#{d[5]}#{d[6]}".to_i.divisible_by?(7)  &&
                         "#{d[5]}#{d[6]}#{d[7]}".to_i.divisible_by?(11) &&
                         "#{d[6]}#{d[7]}#{d[8]}".to_i.divisible_by?(13) &&
                         "#{d[7]}#{d[8]}#{d[9]}".to_i.divisible_by?(17)
end

p sum
