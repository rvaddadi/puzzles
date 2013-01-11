require_relative 'holes/calculator'
require_relative 'holes/cli'

if __FILE__ == $0
  puts Holes::Cli.new.process($stdin.read)
end
