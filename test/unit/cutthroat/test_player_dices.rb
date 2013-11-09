
require 'test/unit'
require 'cutthroat'

require 'stub_dices'

class TestPlayerDices < Test::Unit::TestCase

  def setup
    @player = Cutthroat::Player.new()
    @dices = StubDices.new
    @dices.sequence = [[3, 2]]
  end

  def test_player_rolls_dices
    @player.play_turn(@dices)
    assert(@dices.roll_called == 1,
           "player should roll dices on turn, rolled #{@dices.roll_called}")
  end

  def test_player_moves_forward
    @dices.sequence = [[3, 2]]
    @player.move_to(7)
    @player.play_turn(@dices)
    assert(@player.location == 12,
           "player moves forward to 12 when rolled 5, is at #{@player.location}")
  end

  def test_player_turnaround
    @dices.sequence = [[3, 5]]
    @player.move_to(38)
    @player.play_turn(@dices)
    assert(@player.location == 6,
           "player wraps forward to 6, is at #{@player.location}")
  end

  def test_turns_played
    @player.play_turn(@dices)
    assert(@player.turns_played == 1,
           "player played #{@player.turns_played} turns")
  end
end
