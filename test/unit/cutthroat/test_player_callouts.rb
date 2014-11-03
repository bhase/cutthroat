require 'test/unit'
require 'cutthroat'

class TestPlayerCallouts < Test::Unit::TestCase

  def setup
    @player = Cutthroat::Player.new()
    @user_callout = mock
    @player.register_callouts(@user_callout)
  end


  def test_buy_decision_from_user
    @user_callout.expects(:buy_property?)
    @player.buy_property?(nil)
  end

  def test_pre_hook
    @user_callout.expects(:pre_hook)
    @player.pre_hook
  end
end
