# This isn't the best solution. I reproduce the whole spiral and the sum, instead of using the
# series.
# But it's very elegant and knows how to print the spiral :D

class Spiral < Array
  def self.form_spiral(size = 1001)
    matrix = Spiral.new(size) {Array.new(size) {0}}
    position = {x: size / 2, y: size / 2}
    element = 1
    direction = :right
    while 0 <= position[:x] and position[:x] < size and 0 <= position[:y] and position[:y] < size
      matrix[position[:y]][position[:x]] = element
      position[:x] += 1  if direction == :right
      position[:x] -= 1  if direction == :left
      position[:y] += 1  if direction == :down
      position[:y] -= 1  if direction == :up
      direction = :down  if direction == :right and matrix[position[:y] + 1][position[:x]] == 0
      direction = :left  if direction == :down  and matrix[position[:y]][position[:x] - 1] == 0
      direction = :up    if direction == :left  and matrix[position[:y] - 1][position[:x]] == 0
      direction = :right if direction == :up    and matrix[position[:y]][position[:x] + 1] == 0
      element += 1
    end
    matrix
  end
  def sum_diagonals
    sum = self[size / 2][size / 2]
    (0...(size / 2)).each do |i|
      sum += self[i][i] + self[ - (i + 1)][i] + self[i][ - (i + 1)] + self[ - (i + 1)][ - (i + 1)]
    end
    sum
  end
  def inspect
    self.map { |line| line.join("\t") }.join("\n")
  end
end

p Spiral.form_spiral.sum_diagonals
