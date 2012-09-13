f0 = 0
f1 = 1
index = 1
while f1.to_s.size < 1000
  f0, f1 = f1, f0 + f1
  index += 1
end
p index