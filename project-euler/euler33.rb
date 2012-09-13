require 'mathn'

final_fraction = 1
(10..99).each do |numerator|
  (10..99).each do |denominator|
    if numerator < denominator
      fraction = numerator / denominator
      numerator_s = numerator.to_s
      denominator_s = denominator.to_s
      final_fraction *= fraction if denominator_s[0].to_i != 0 && numerator_s[0] == denominator_s[1] &&
          fraction == numerator_s[1].to_i / denominator_s[0].to_i ||
          denominator_s[1].to_i != 0 && numerator_s[1] == denominator_s[0] &&
          fraction == numerator_s[0].to_i / denominator_s[1].to_i
    end
  end
end

p final_fraction.denominator