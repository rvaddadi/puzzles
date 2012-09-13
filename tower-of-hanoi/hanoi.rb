require 'set'

class Node

  attr_reader :situation, :moves

  def initialize(situation, moves = [])
    @situation = situation
    @moves     = moves
  end

  def ==(other)
    situation == other.situation
  end
end

def read_line
  gets.strip.split(' ').map(&:to_i)
end

n, k = read_line

current_node  = Node.new(read_line)
final_node    = Node.new(read_line)

queue         = Array.new
visited_nodes = Set.new

loop do
  available_pegs = (1..k).to_a

  current_node.situation.each_with_index do |orig_peg, index|
    if available_pegs.include? orig_peg
      available_pegs.delete orig_peg

      break if available_pegs.empty?

      available_pegs.each do |dest_peg|
        new_situation        = current_node.situation.dup
        new_situation[index] = dest_peg

        new_moves            = current_node.moves.dup
        new_moves            << "#{ orig_peg } #{ dest_peg }"

        new_node = Node.new(new_situation, new_moves)

        if new_node == final_node
          puts new_node.moves.count, new_node.moves
          exit
        end

        queue << new_node unless visited_nodes.include?(new_node) || queue.include?(new_node)
      end
    end
  end

  visited_nodes.add current_node
  current_node = queue.shift
end
