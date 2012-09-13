require 'simplecov'
SimpleCov.start

require 'test/unit'
require_relative 'url_sorter'

class TestUrlSorter < Test::Unit::TestCase

  def setup
    @url_sorter = UrlSorter.new
  end

  def test_empty_string
    assert_equal '', @url_sorter.sort_url('')
  end

  def test_no_query_params
    assert_equal '/test.php', @url_sorter.sort_url('/test.php')
  end

  def test_trailing_question_mark
    assert_equal '/test.php', @url_sorter.sort_url('/test.php?')
  end

  def test_one_query_param
    assert_equal '/test.php?a=3', @url_sorter.sort_url('/test.php?a=3')
  end

  def test_two_query_params_out_of_order
    assert_equal '/test.php?a=3&b=b', @url_sorter.sort_url('/test.php?b=b&a=3')
  end

  def test_two_query_params_with_same_name
    assert_equal '/test.php?a=3&a=4', @url_sorter.sort_url('/test.php?a=4&a=3')
  end

  def test_case_sample
    assert_equal '/test.php?a=3&a=4&b=b&c=bb', @url_sorter.sort_url('/test.php?b=b&c=bb&a=3&a=4')
  end
end
