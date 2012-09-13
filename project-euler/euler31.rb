def combinations(coins, total = 0, target = 200)
  # p [coins, '||', total]*'|'
  # gets
  return 0 if total > target
  if coins.empty?
    return 1 if total == target
    return 0 if total != target
  end
  coin = coins.shift
  count = (0..(target / coin))
    .map { |i| combinations(coins, total + coin * i) }
    .reduce(:+)
  coins << coin
  count
end

p combinations([1, 2, 5, 10, 20, 50, 100, 200])
