class Node

  attr_reader :value, :parent, :direction

  def initialize(value, parent = nil, direction = nil)
    @value     = value
    @parent    = parent
    @direction = direction
  end

end

class NodeWithChildren

  attr_reader   :node
  attr_accessor :left, :right

  def initialize(node)
    @node = node
  end
end

class NextNodeResolver

  def initialize(leafs)
    @nexts = {}

    nodes_to_process              = leafs
    nodes_processed_with_children = []
    root                          = nil

    until nodes_to_process.empty?

      node_to_process = nodes_to_process.pop

      node_to_process_with_children = NodeWithChildren.new(node_to_process)

      nodes_processed_with_children.each do |node_processed_with_children|
        if node_processed_with_children.node.parent == node_to_process

          case node_processed_with_children.node.direction
          when :left  then node_to_process_with_children.left  = node_processed_with_children
          when :right then node_to_process_with_children.right = node_processed_with_children
          end

        end
      end


      if node_to_process.parent.nil?
        root = node_to_process_with_children
      elsif ! (nodes_to_process & nodes_processed_with_children.map(&:node)).include? node_to_process.parent
        nodes_to_process << node_to_process.parent
      end

      nodes_processed_with_children << node_to_process_with_children

    end

    previous_node = nil

    depth_first_seach = ->(node_with_children) do

      unless node_with_children.nil?

        depth_first_seach.(node_with_children.left)
        @nexts[previous_node]      = node_with_children.node unless previous_node.nil?
        previous_node              = node_with_children.node
        depth_first_seach.(node_with_children.right)

      end
    end

    depth_first_seach.(root)

  end

  def resolve(node)
    @nexts[node]
  end
end
