
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
    location.record_rights(@player)
    assert_equal([location], @game.find_locations_owned_by(@player))
  end

  def test_find_locations_owned_by_two_owned
    l1 = @game.find_location(1)
    l1.record_rights(@player)
    l2 = @game.find_location(14)
    l2.record_rights(@player)
    assert_equal([l1, l2], @game.find_locations_owned_by(@player))
  end

  def test_find_locations_of_group
    l1 = @game.find_location(1)
    l2 = @game.find_location(3)
    assert_equal([l1, l2], @game.find_locations_of_group(:street1))
  end

end
