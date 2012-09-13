# run with `ruby most_used_commands.rb [quantity of commands]`

QUANTITY = (ARGV[0] || 10).to_i
commands = Hash.new(0)
File.open(File.expand_path('~/.bash_history'), 'r') do |file|
  file.each_line do |line|
    line.split(/[;|]|[^>]&/).each do |command|
      commands[command.strip.split(/ /).first] += 1
    end
  end
end
commands.sort_by { |command, count| count }.reverse.first(QUANTITY).each_with_index do |command, i|
  puts "#{i + 1}: #{command[0]} (#{command[1]})"
end
