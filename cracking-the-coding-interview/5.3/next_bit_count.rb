def next_bit_count(n)
  bit_count = ->(n) { n.to_s(2).each_char.to_a.count '1' }

  n_bit_count = bit_count.(n)

  next_smallest = next_largest = n

  begin next_smallest -= 1 end until n_bit_count == bit_count.(next_smallest)
  begin next_largest  += 1 end until n_bit_count == bit_count.(next_largest)

  [ next_smallest, next_largest ]
end

p next_bit_count('1001'.to_i(2))
p [ '110'.to_i(2), '1010'.to_i(2) ]
