require_relative 'helper'

module Holes

  class CliTest < Test::Unit::TestCase

    def setup
      @cli = Cli.new
    end

    def test_parser
      assert_equal ['paralelepipedo', 'hello', ' this is spartaaa'],
        @cli.parse('3:paralelepipedo;hello; this is spartaaa;')
    end

    def test_calculate
      assert_equal [10, 2, 5],
        @cli.calculate(['paralelepipedo', 'hello', ' this is spartaaa'])
    end

    def test_format
      assert_equal '10;2;5',
        @cli.format([10, 2, 5])
    end

    def test_process
      assert_equal '10;2;5', @cli.process('3:paralelepipedo;hello; this is spartaaa;')
    end
  end
end
