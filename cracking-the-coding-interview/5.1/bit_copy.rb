def bit_copy(n, m, i, j)

  mask = (2^(j - i) - 1) << i ^ 0xFFFF

  n & mask | m << i

end

if $0 == __FILE__
  puts bit_copy('10000000000'.to_i(2), '10101'.to_i(2), 2, 6).to_s(2)
end
