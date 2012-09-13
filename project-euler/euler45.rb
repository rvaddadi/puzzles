limit = 100000
series = {triangular: [], pentagonal: [], hexagonal: []}
(1..limit).map do |n|
  series[:triangular] << n * (    n + 1) / 2
  series[:pentagonal] << n * (3 * n - 1) / 2
  series[:hexagonal]  << n * (2 * n - 1)
end
p (series[:triangular] & series[:pentagonal] & series[:hexagonal])[2]
