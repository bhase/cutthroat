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

  def test_buy_decision_from_user
    user_callout = mock
    user_callout.expects(:buy_property?)
    @player.register_callouts(user_callout)
    @player.buy_property?(nil)
  end

  def test_jail_exit_from_user
    user_callout = mock
    user_callout.expects(:leave_jail_with?)
    @player.register_callouts(user_callout)
    @player.leave_jail_with?
  end

end
