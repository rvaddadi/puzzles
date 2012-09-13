require 'benchmark'

STRING = <<EOF
Not only did we run and time our code, but we did it multiple times producing, the user, system, total and real times for each run. You can imagine how useful this could be especially considering that if we use one of the other methods of the Benchmark module (Benchmark.benchmark) it will allow us to format our output as well as easily produce averages and totals for all the runs.
EOF

TIMES = 10_000

Benchmark.bm(20) do |b|
  b.report('split:')          { TIMES.times { STRING.split(//)      } }
  b.report('each_char.to_a:') { TIMES.times { STRING.each_char.to_a } }
end


# Result:
#
# user     system      total        real
# split:                 1.420000   0.000000   1.420000 (  1.424929)
# each_char.to_a:        0.430000   0.000000   0.430000 (  0.429164)
