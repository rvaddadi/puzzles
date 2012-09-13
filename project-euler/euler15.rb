#certainly there is a better way than doing the whole grid!
#but this one solves the problem :P
def grid(size)
  g = Array.new(size + 1) { Array.new(size + 1) }
  (0..size).each { |i| g[size][i] = g[i][size] = 1 }
  (size - 1).downto(0) do |y|
    (size - 1).downto(0) do |x|
      g[x][y] = g[x + 1][y] + g[x][y + 1]
    end
  end
  g[0][0]
end
p grid(20)