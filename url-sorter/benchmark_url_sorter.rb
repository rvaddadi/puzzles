require 'benchmark'
require_relative 'url_sorter'

url_sorter = UrlSorter.new
TIMES = 100_000

puts Benchmark.measure { TIMES.times { url_sorter.sort_url('/test.php?b=b&c=bb&a=3&a=4') } }

#   1.210000   0.000000   1.210000 (  1.205235)
#   Lame! :P
