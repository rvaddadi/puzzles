products = []

(1..9).to_a.permutation.each do |permutation|
  permutation = permutation.join
  (1..permutation.size - 1).each do |multiplicand_limit|
    (multiplicand_limit + 1..permutation.size - 1).each do |multiplier_limit|
      multiplicand = permutation[0...multiplicand_limit].to_i
      multiplier = permutation[multiplicand_limit...multiplier_limit].to_i
      product    = permutation[multiplier_limit..-1].to_i
      products << product if (multiplicand * multiplier == product) && (not products.include? product)
    end
  end
end

p products.reduce(:+)
