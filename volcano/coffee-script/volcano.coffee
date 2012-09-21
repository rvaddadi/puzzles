_  = require 'underscore'

exports.solve = (gridString) ->

  volcanos            = []
  cities              = []
  daysUntilEndOfTimes = 0

  _.each gridString.split("\n"), (line, i) ->
      _.each line.split(''), (char, j) ->
        switch char
          when 'X' then volcanos.push { x: i, y: j }
          when '*' then cities  .push { x: i, y: j }

  _.each cities, (city) ->

    distanceBetweenCityAndClosestVolcano = Infinity

    _.each volcanos, (volcano) ->
      distanceBetweenCityAndCurrentVolcano = Math.abs(city.x - volcano.x) + Math.abs(city.y - volcano.y)
      distanceBetweenCityAndClosestVolcano = distanceBetweenCityAndCurrentVolcano if distanceBetweenCityAndClosestVolcano > distanceBetweenCityAndCurrentVolcano

    daysUntilEndOfTimes = distanceBetweenCityAndClosestVolcano if distanceBetweenCityAndClosestVolcano > daysUntilEndOfTimes

  daysUntilEndOfTimes
