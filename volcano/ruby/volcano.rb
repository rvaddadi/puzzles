require 'ostruct'

def volcano(grid)

  volcanos = []
  cities   = []
  days_until_end_of_times = 0

  grid.split("\n").each_with_index do |line, i|
    line.each_char.each_with_index do |char, j|
      case char
      when '*'
        cities   << OpenStruct.new(x: i, y: j)
      when 'X'
        volcanos << OpenStruct.new(x: i, y: j)
      end
    end
  end

  cities.each do |city|

    distance_between_city_and_closest_volcano = Float::INFINITY

    volcanos.each do |volcano|
      distance_between_city_and_current_volcano = (city.x - volcano.x).abs + (city.y - volcano.y).abs
      distance_between_city_and_closest_volcano = distance_between_city_and_current_volcano if distance_between_city_and_closest_volcano > distance_between_city_and_current_volcano
    end

    days_until_end_of_times = distance_between_city_and_closest_volcano if distance_between_city_and_closest_volcano > days_until_end_of_times
  end

  days_until_end_of_times

end
