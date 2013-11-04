require 'test/unit'
require 'cutthroat/player'

class TestPlayerBalance < Test::Unit::TestCase

  def setup
    @player = Cutthroat::Player.new()
  end

  def test_initial_balance
    assert_equal(@player.balance, 1500)
  end

end
