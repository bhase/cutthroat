
require 'test/unit'
require 'mocha/setup'
require 'cutthroat'
require 'test_helper'

require 'stub_dice'

class TestPlayerDice < Test::Unit::TestCase

  def setup
    @game = Cutthroat::Game.new
    @player = default_player
    @dice = StubDice.new
    @dice.sequence = [[3, 2]]
    @game.instance_variable_set(:@dice, @dice)
  end

  def test_player_rolls_dice
    @game.play_turn(@player)
    assert(@dice.roll_called == 1,
           "player should roll dice on turn, rolled #{@dice.roll_called}")
  end

  def test_player_moves_forward
    @dice.sequence = [[3, 2]]
    @player.move_to(@game.find_location(7))
    @game.play_turn(@player)
    assert(@player.location.to_i == 12,
           "player moves forward to 12 when rolled 5, is at #{@player.location}")
  end

  def test_player_turnaround
    @dice.sequence = [[3, 5]]
    @player.move_to(38)
    @game.play_turn(@player)
    assert(@player.location.to_i == 6,
           "player wraps forward to 6, is at #{@player.location}")
  end

  def test_turns_played
    @game.play_turn(@player)
    assert(@player.turns_played == 1,
           "player played #{@player.turns_played} turns")
  end

  def test_player_finds_location
    location = mock
    location.expects(:trigger_action).with(@player)
    @game.expects(:find_location).returns(location)
    @game.play_turn(@player)
  end
end
