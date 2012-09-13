names = eval("[" + File.open("euler22.txt").first + "]")
class String
  def alphabetical_value
    self.split(//).map { |character| character.ord - 64 }.reduce(:+)
  end
end
position = 0
p names.sort.map { |name| position += 1; name.alphabetical_value * position}.reduce(:+)