
require 'test/unit'
require 'cutthroat/game'
require 'cutthroat/dice'

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

  def test_cancel_game
    game = add_two_player(Cutthroat::Game.new())
    game.start
    game.cancel
    assert_equal(false, game.active, "game should not be active after cancel")
  end

  def test_start_empty_fails
    assert_raises(Cutthroat::TooFewPlayerError) { @game.start }
  end

  def test_play_round
    game = add_two_player(Cutthroat::Game.new())
    game.start
    game.play_round
    game.players.each { |p|
      assert_equal(p.turns_played, 1, "the player played #{p.turns_played} turns instead of 1")
    }
  end

  def add_two_player(game)
    game.add_player(Cutthroat::Player.new("abc"))
    game.add_player(Cutthroat::Player.new("def"))
    game
  end
end
