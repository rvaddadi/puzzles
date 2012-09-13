require 'date'

sundays = 0
(1901..2000).each { |year| (1..12).each { |month| sundays += 1 if Date::civil(year, month, 1).wday == 0 } }
p sundays