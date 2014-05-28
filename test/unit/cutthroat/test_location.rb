
require 'test/unit'
require 'cutthroat/game'
require 'cutthroat'

class TestLocation < Test::Unit::TestCase

  def setup
    @player = Cutthroat::Player.new
    @player.expects(:'buy_property?').returns(false).at_least_once
  end

  def test_location_action_asks_player_to_buy
    loc = Cutthroat::Location.new
    loc.trigger_action(@player)
  end

  def test_location_respects_player_decision
    loc = Cutthroat::Location.new
    loc.trigger_action(@player)
    assert_equal(nil, loc.owner)
  end

  def test_location_respects_player_decision_to_buy
    @player.unstub(:'buy_property?')
    @player.expects(:'buy_property?').returns(true).at_least_once
    loc = Cutthroat::Location.new
    loc.instance_variable_set("@land_price", 10)
    loc.trigger_action(@player)
    assert_equal(@player, loc.owner)
  end

end
