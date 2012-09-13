require 'test/unit'
require_relative 't9'

class TestT9 < Test::Unit::TestCase

  def setup
    @t9 = T9.new
  end

  def test_to_t9
    assert_equal '77773367_7773302_222337777_777766606660366656667889999_9999555337777',
      @t9.to_t9('SEMPRE ACESSO O DOJOPUZZLES')
  end

  def test_from_t9
    assert_equal 'SEMPRE ACESSO O DOJOPUZZLES',
      @t9.from_t9('77773367_7773302_222337777_777766606660366656667889999_9999555337777')
  end
end
