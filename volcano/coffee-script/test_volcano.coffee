fs      = require 'fs'
volcano = require './volcano'

fs.readFile '../test_cases/case-1.txt', 'ascii', (err, data) ->
  console.log(volcano.solve(data) == 5)

fs.readFile '../test_cases/case-2.txt', 'ascii', (err, data) ->
  console.log(volcano.solve(data) == 4)
