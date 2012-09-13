# a little longer than 1 min, but this code is soooo pretty :D

p (0..9).to_a.permutation.map { |permutation| permutation.join('') }.sort[999_999]
