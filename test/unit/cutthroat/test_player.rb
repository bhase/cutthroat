
require 'test/unit'
require 'cutthroat/player'

require 'stub_dices'

class TestPlayer < Test::Unit::TestCase

  def setup
    @player = Cutthroat::Player.new()
  end

  def test_new_player
    refute_nil(@player)
  end

  def test_player_location
    @player.move_to(4)
    assert(@player.location == 4)
  end

  def test_player_initial_location
    assert(@player.location == 0, "new players should be on start")
  end

  def test_player_rolls_dices
    dices = StubDices.new
    dices.sequence = [4, 2]
    @player.play_turn(dices)
    assert(dices.roll_called == 2,
           "player should roll two dices on turn, rolled #{dices.roll_called}")
  end

  def test_player_moves_forward
    dices = StubDices.new
    dices.sequence = [3, 2]
    @player.move_to(7)
    @player.play_turn(dices)
    assert(@player.location == 12,
           "player moves forward to 12 when rolled 5, is at #{@player.location}")
  end
end
