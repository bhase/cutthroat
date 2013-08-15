
require 'test/unit'
require 'cutthroat/game'

class TestGame < Test::Unit::TestCase

  def setup
    @game = Cutthroat::Game.new()
  end

  def test_new_game
    refute_nil(@game)
  end

  def test_add_player
    player = Cutthroat::Player.new()
    @game.add_player(player)
    assert_equal(player, @game.players.first)
  end

end
