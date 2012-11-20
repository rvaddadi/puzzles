require 'test/unit'

class Point

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def distance(other)
    Math.sqrt((x - other.x) ** 2 + (y - other.y) ** 2)
  end
end

class MagnectEffectCalculador

  def initialize(magnect_points, radius)
    @magnect_points = magnect_points
    @radius          = radius
  end

  def calculate(point)
    min_distance_point_with_distance = @magnect_points.map { |magnect_point|
      {
        point:    magnect_point,
        distance: magnect_point.distance(point),
      }
    }.min_by { |magnect_point_with_distance| magnect_point_with_distance[:distance] }

    if min_distance_point_with_distance[:distance] <= @radius
      min_distance_point_with_distance[:point]
    else
      point
    end
  end
end

class PointTest < Test::Unit::TestCase

  def test_equals
    assert_equal Point.new(2, 3), Point.new(2, 3)
  end

  def test_not_equals
    assert_not_equal Point.new(2, 3), Point.new(2, 4)
  end

  def test_distance_same_point
    assert_equal 0, Point.new(2, 3).distance(Point.new(2, 3))
  end

  def test_distance_in_x_axis
    assert_equal 1, Point.new(2, 3).distance(Point.new(3, 3))
  end

  def test_distance_in_y_axis
    assert_equal 1, Point.new(2, 3).distance(Point.new(2, 2))
  end

  def test_distance_in_both_axis
    assert_equal 5, Point.new(0, 0).distance(Point.new(3, 4))
  end
end

class MagnectEffectCalculatorTest < Test::Unit::TestCase

  def test_far_point
    assert_equal Point.new(0, 0), MagnectEffectCalculador.new([
       Point.new(50, 50),
    ], 5).calculate(Point.new(0, 0))
  end

  def test_point_in_radius
    assert_equal Point.new(50, 50), MagnectEffectCalculador.new([
       Point.new(50, 50),
    ], 5).calculate(Point.new(49, 50))
  end

  def test_point_with_two_magnects_in_radius
    assert_equal Point.new(51, 51), MagnectEffectCalculador.new([
       Point.new(50, 50),
       Point.new(51, 51),
    ], 5).calculate(Point.new(51, 52))
  end
end
