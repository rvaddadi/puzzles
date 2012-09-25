require 'test/unit'
require_relative 'next_node'

class TestNextNode < Test::Unit::TestCase

  #          3
  #        /   \
  #       1     5
  #        \   /
  #         2 4

  def setup
    @node_3 = Node.new(3)
    @node_1 = Node.new(1, @node_3, :left)
    @node_2 = Node.new(2, @node_1, :right)
    @node_5 = Node.new(5, @node_3, :right)
    @node_4 = Node.new(4, @node_5, :left)

    @next_node_resolver = NextNodeResolver.new([@node_2, @node_4])
  end

  def test_1
    assert_equal @node_2, @next_node_resolver.resolve(@node_1)
  end

  def test_2
    assert_equal @node_3, @next_node_resolver.resolve(@node_2)
  end

  def test_3
    assert_equal @node_4, @next_node_resolver.resolve(@node_3)
  end

  def test_4
    assert_equal @node_5, @next_node_resolver.resolve(@node_4)
  end

  def test_5
    assert_equal nil,     @next_node_resolver.resolve(@node_5)
  end

end
