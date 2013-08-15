
require 'test/unit'
require 'cutthroat/game'

class TestGame < Test::Unit::TestCase

  def setup
    @game = Cutthroat::Game.new()
  end

  def test_new_game
    refute_nil(@game)
  end

end
