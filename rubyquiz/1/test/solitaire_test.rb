require 'test/unit'
require_relative '../lib/solitaire'

class SolitaireTest < Test::Unit::TestCase
  def setup
    @solitaire = Solitaire.new((1..54).to_a)
  end

  def test_decks_size
    assert_raise(ArgumentError) { Solitaire.new((1..53).to_a) }
    assert_raise(ArgumentError) { Solitaire.new((1..55).to_a) }
  end

  def test_decks_content
    assert_raise(ArgumentError) { Solitaire.new([0]  * 54) }
    assert_raise(ArgumentError) { Solitaire.new([55] * 54) }
  end

  def test_encrypt_given_case
    assert_equal 'GLNCQ MJAFF FVOMB JIYCB',
      @solitaire.encrypt('Code in Ruby, live longer!')
  end

  def test_decrypt_given_case
    assert_equal 'CODEI NRUBY LIVEL ONGER',
      @solitaire.decrypt('GLNCQ MJAFF FVOMB JIYCB')
  end
end
