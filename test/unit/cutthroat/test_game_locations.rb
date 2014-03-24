
require 'test/unit'
require 'cutthroat/game'
require 'cutthroat'

class TestGameLocations < Test::Unit::TestCase

  def setup
    @game = Cutthroat::Game.new
    @player = Cutthroat::Player.new
    callouts = mock
    # used to remove record_rights from test
    # now using trigger_action. This may be
    # a little bit indirect, but uses the public
    # API. Another possibility would be to
    # use instance_variable_set
    callouts.stubs(:buy_property?).returns(true)
    @player.register_callouts(callouts)
  end

  def test_find_locations_owned_by_none_owned
    assert_equal([], @game.find_locations_owned_by(@player))
  end

  def test_find_locations_owned_by_one_owned
    location = @game.find_location(5)
    location.trigger_action(@player)
    assert_equal([location], @game.find_locations_owned_by(@player))
  end

  def test_find_locations_owned_by_two_owned
    l1 = @game.find_location(1)
    l1.trigger_action(@player)
    l2 = @game.find_location(14)
    l2.trigger_action(@player)
    assert_equal([l1, l2], @game.find_locations_owned_by(@player))
  end

  def test_find_locations_of_group
    l1 = @game.find_location(1)
    l2 = @game.find_location(3)
    assert_equal([l1, l2], @game.find_locations_of_group(:street1))
  end

end
