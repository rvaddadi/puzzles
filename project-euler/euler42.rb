class Integer
  def triangular?
    double = self * 2
    double_sqrt = Math.sqrt double
    double_sqrt.ceil != double_sqrt.floor and double == double_sqrt.ceil * double_sqrt.floor
  end
end
class String
  def convert_letters
    self.split(//).map { |letter| letter.ord - 64 }.reduce(:+)
  end
end

names = eval("["+ File.open('euler42.txt').first + "]")
p names.select { |name| name.convert_letters.triangular? }.size
