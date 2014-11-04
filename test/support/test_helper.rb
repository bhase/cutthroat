
def default_player(name = "anonymous")
  player = Cutthroat::Player.new(name)
  callouts = mock
  callouts.stubs(:buy_property?).returns(false)
  callouts.stubs(:pre_hook).returns(:roll_dice)
  player.register_callouts(callouts)
  player
end
