
require 'test/unit'
require 'cutthroat/game'
require 'cutthroat'

class TestGameLocations < Test::Unit::TestCase

  def setup
    @game = Cutthroat::Game.new
    @player = Cutthroat::Player.new
  end

  def test_find_locations_owned_by_none_owned
    assert_equal([], @game.find_locations_owned_by(@player))
  end

  def test_find_locations_owned_by_one_owned
    location = @game.find_location(5)
    location.owner =  @player
    assert_equal([location], @game.find_locations_owned_by(@player))
  end

  def test_find_locations_owned_by_two_owned
    l1 = @game.find_location(1)
    l1.owner = @player
    l2 = @game.find_location(14)
    l2.owner = @player
    assert_equal([l1, l2], @game.find_locations_owned_by(@player))
  end

end
