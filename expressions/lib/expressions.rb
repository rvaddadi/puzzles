def resolve expression
  expression.strip!
  fail ArgumentError, 'Blank expression' if expression =~ /\A\z/

  expression.gsub!(/\((.*)\)/) { resolve $1 }

  case expression
  when /\A\d+\z/
    expression.to_i
  when /\A(.*)(\+|-)(.*)\z/
    if $2 == '+'
      resolve($1) + resolve($3)
    elsif $2 == '-'
      resolve($1) - resolve($3)
    end
  when /\A(.*)(\*|\/)(.*)\z/
    if $2 == '*'
      resolve($1) * resolve($3)
    elsif $2 == '/'
      resolve($1) / resolve($3)
    end
  end
end
