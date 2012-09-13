limit = 1_000_000
class Integer
  @@steps_cache = {}
  def count_steps
    return @@steps_cache[self] if @@steps_cache.include? self
    return @@steps_cache[self] = 1 if self == 1
    return @@steps_cache[self] = 1 + (self / 2).count_steps if self % 2 == 0
    @@steps_cache[self] = 1 + (3 * self + 1).count_steps
  end
end
p (1...limit).map { |number| {number: number, steps: number.count_steps } }.max { |a, b| a[:steps] <=> b[:steps] }[:number]

