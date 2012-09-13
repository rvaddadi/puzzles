class Integer
  def digits
    self.to_s.split(//).sort
  end
end
i = 1
loop do
  i_digits = i.digits
  if      i_digits == (2 * i).digits\
      and i_digits == (3 * i).digits\
      and i_digits == (4 * i).digits\
      and i_digits == (5 * i).digits\
      and i_digits == (6 * i).digits
    p i
    break
  end
  i += 1
end