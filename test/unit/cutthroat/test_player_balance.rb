require 'test/unit'
require 'cutthroat'

class TestPlayerBalance < Test::Unit::TestCase

  def setup
    @player = Cutthroat::Player.new()
  end

  def test_initial_balance
    assert_equal(@player.balance, Cutthroat::SEED_CAPITAL)
  end

  def test_player_receives
    @player.receive(200)
    assert_equal(Cutthroat::SEED_CAPITAL + 200, @player.balance)
  end

end
