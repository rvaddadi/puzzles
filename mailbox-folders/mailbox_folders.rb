require 'set'

class Node

  attr_accessor :id, :parent_id, :name, :children

  def initialize(id, parent_id, name)
    @id        = id.to_i
    @parent_id = parent_id.to_i
    @name      = name
    @children  = Set.new
  end

  def root?
    @parent_id == 0
  end

  def to_s
    "#{ @name }:#{ @id }"
  end
end

roots         = Set.new
pending_nodes = Set.new

while line = gets

  node = Node.new *line.strip.split(',')

  if node.root?
    roots << node
    pending_nodes.each do |pending_node|
      if pending_node.parent_id == node.id
        node.children << pending_node
        pending_nodes.delete pending_node
      end
    end
  else
    found = false
    roots.each do |root|
      if root.id == node.parent_id
        root.children << node
        found = true
      end
    end
    pending_nodes << node unless found
  end

end

print_tree = ->(nodes, indentation_level = 0) do
  unless nodes.nil?
    nodes.sort_by(&:name).each do |node|
      puts "\t" * indentation_level + node.to_s
      print_tree.(node.children, indentation_level + 1)
    end
  end
end

print_tree.(roots)
