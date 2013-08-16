
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

  def test_start_game
    game = add_two_player(Cutthroat::Game.new())
    assert_equal(false, game.active, "game not active by default")
    game.start
    assert_equal(true, game.active, "game should be actvie after start")
  end


  def add_two_player(game)
    game.add_player(Cutthroat::Player.new("abc"))
    game.add_player(Cutthroat::Player.new("def"))
    game
  end
end
