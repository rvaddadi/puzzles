require 'test/unit'

class LCASearcher

  def initialize(tree)
    @ancestors = {}
    @ancestors_step = []
    calculate_ancestors_step(tree.root)
  end

  def lca_search(a, b)
    (@ancestors[a] & @ancestors[b]).last
  end

  private

    def calculate_ancestors_step(node)

      @ancestors_step << node.value

      @ancestors[node.value] = @ancestors_step.dup

      calculate_ancestors_step(node.left)  unless node.left.nil?
      calculate_ancestors_step(node.right) unless node.right.nil?

      @ancestors_step.pop

    end
end


class Node

  attr_accessor :value, :left, :right

end

class Tree

  attr_accessor :root

  def lca(a, b)
    LCASearcher.new(self).lca_search(a, b)
  end
end

class TestLCA < Test::Unit::TestCase

  # @tree
  #
  #           5
  #         /    \
  #      10        -10
  #    /     \     /
  # 1         2   3
  def setup
    node_1 = Node.new
    node_1.value = 1

    node_2 = Node.new
    node_2.value = 2

    node_3 = Node.new
    node_3.value = 3

    node_10 = Node.new
    node_10.value = 10
    node_10.left  = node_1
    node_10.right = node_2

    node_minus_10 = Node.new
    node_minus_10.value = -10
    node_minus_10.left  = node_3

    node_5 = Node.new
    node_5.value = 5
    node_5.left  = node_10
    node_5.right = node_minus_10

    @tree = Tree.new
    @tree.root = node_5
  end

  def test_trivial_root
    assert_equal 5, @tree.lca(5, 5)
  end

  def test_trivial_non_root_left
    assert_equal 10, @tree.lca(10, 10)
  end

  def test_trivial_non_root_right
    assert_equal -10, @tree.lca(-10, -10)
  end

  def test_immediate_child_left
    assert_equal 5, @tree.lca(5, 10)
  end

  def test_immediate_child_right
    assert_equal 5, @tree.lca(5, -10)
  end

  def test_two_immediate_children
    assert_equal 5, @tree.lca(10, -10)
  end

  def test_non_root_two_immediate_children
    assert_equal 10, @tree.lca(1, 2)
  end

  def test_distant_child_node
    assert_equal 5, @tree.lca(1, 5)
  end

  def test_distant_nodes
    assert_equal 5, @tree.lca(1, 3)
  end

  def test_inddiferent_to_order
    test_cases = [[5, 10], [5, 5], [-10, 10], [5, 10]]

    test_cases.each do |test_case|
      assert_equal @tree.lca(*test_case), @tree.lca(*(test_case.reverse))
    end
  end
end
