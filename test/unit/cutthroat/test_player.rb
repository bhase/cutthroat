require 'test/unit'
require 'cutthroat'

class TestPlayer < Test::Unit::TestCase

  def setup
    @player = Cutthroat::Player.new()
  end

  def test_new_player
    refute_nil(@player)
    assert(@player.turns_played == 0, "new player should have played 0 turns")
  end

  def test_player_location
    @player.move_to(4)
    assert(@player.location == 4)
  end

  def test_player_initial_location
    assert(@player.location == nil, "new players should have no location")
  end

  def test_init_takes_name
    player = Cutthroat::Player.new("test player")
    assert_equal("test player", player.name)
  end

  def test_missing_method_does_not_swallow_event
    # method_missing in Player should use super, but this not that easy
    # to test - at least I do not know how. So at least we test for an
    # exception (which is also raised by calling super)
    assert_raises() { @player.definitive_not_existing_method_xlkhgalskhd }
  end

end
