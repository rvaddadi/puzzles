def decimal_to_binary(n)
  result = ''

  integer_part, decimal_part = n.split('.').map(&:to_i)

  while integer_part > 0
    result.prepend (integer_part  % 2).to_s
    integer_part /= 2
  end

  decimal_digits = 1
  decimal_part   = "0.#{ decimal_part.to_s }".to_f
  result << '.'

  while decimal_part > 0
    return 'ERROR' if decimal_digits > 10

    factor = 1.0 / 2**decimal_digits

    result << if decimal_part >= factor
                decimal_part -= factor
                '1'
              else
                '0'
              end

    decimal_digits += 1
  end

  result
end

puts decimal_to_binary('3.5')
puts decimal_to_binary('0.14285714285')
