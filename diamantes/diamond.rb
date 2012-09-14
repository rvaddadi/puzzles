# this is dirty and smells bad :P

class Diamond

  A_ORD = 'A'.ord
  SPACE = ' '

  def draw(letter)
    diamond       = ''
    offset        = letter.ord - A_ORD + 1

    space_before  = offset - 1
    space_between = -1

    (0...offset).each do |n|

      letter = ( A_ORD + n ).chr

      diamond << SPACE * space_before +
          letter +
          ( space_between > 0 ? SPACE * space_between + letter : '' ) + "\n"

      space_before  -= 1
      space_between += 2
    end

    space_before  += 2
    space_between -= 4

    (offset - 1).downto(0).each do |n|
      letter = ( A_ORD + n - 1 ).chr

      diamond << SPACE * space_before +
          letter +
          ( space_between > 0 ? SPACE * space_between + letter : '' ) + "\n"

      space_before  += 1
      space_between -= 2
    end

    diamond
  end

end
