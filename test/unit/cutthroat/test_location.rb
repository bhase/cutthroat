
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

end
