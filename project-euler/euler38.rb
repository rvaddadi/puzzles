class Integer
  def pandigital?
    self.to_s.split(//).map(&:to_i).sort == (1..9).to_a
  end
end

max_pandigital = 123456789

integer = 2
loop do
  pandigital_candidate = integer
  n = 1
  loop do
    n += 1
    pandigital_candidate = (pandigital_candidate.to_s + (integer * n).to_s).to_i
    break if pandigital_candidate.to_s.size > 9
    if pandigital_candidate.pandigital? and pandigital_candidate > max_pandigital
      max_pandigital = pandigital_candidate
      break
    end
  end
  # This means that the number can't be
  # concatenated with its double. The search is over
  break if n == 2 and pandigital_candidate != max_pandigital
  integer += 1
end

p max_pandigital
