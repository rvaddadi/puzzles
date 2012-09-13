class Integer
  def !
    return 1 if self == 0
    (1..self).reduce(:*)
  end
  def c(r)
    self.! / (r.! * (self - r).!)
  end
end

count = 0
(1..100).each do |n|
  (0..n).each do |r|
    count += 1 if n.c(r) > 1_000_000
  end
end

p count