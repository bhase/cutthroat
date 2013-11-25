
require 'test/unit'
require 'mocha/setup'
require 'cutthroat'

require 'stub_dice'

class TestPlayerDice < Test::Unit::TestCase

  def setup
    @player = Cutthroat::Player.new()
    @player.game = mock
    @player.game.expects(:find_location).at_most(3).returns(12)
    @dice = StubDice.new
    @dice.sequence = [[3, 2]]
  end

  def test_player_rolls_dice
    @player.play_turn(@dice)
    assert(@dice.roll_called == 1,
           "player should roll dice on turn, rolled #{@dice.roll_called}")
  end

  def test_player_moves_forward
    @dice.sequence = [[3, 2]]
    @player.move_to(7)
    @player.game.expects(:find_location).returns(12)
    @player.play_turn(@dice)
    assert(@player.location == 12,
           "player moves forward to 12 when rolled 5, is at #{@player.location}")
  end

  def test_player_turnaround
    @dice.sequence = [[3, 5]]
    @player.move_to(38)
    @player.game.expects(:find_location).returns(6)
    @player.play_turn(@dice)
    assert(@player.location == 6,
           "player wraps forward to 6, is at #{@player.location}")
  end

  def test_turns_played
    @player.play_turn(@dice)
    assert(@player.turns_played == 1,
           "player played #{@player.turns_played} turns")
  end

  def test_player_finds_location
    @player.play_turn(@dice)
  end
end
