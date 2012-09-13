class Integer
  def palindromic?(base = 10)
    str = self.to_s(base)
    str == str.reverse
  end
end
p (1...1_000_000).select { |n| n.palindromic? and n.palindromic?(2) }.reduce(:+)
