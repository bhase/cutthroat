
def default_player(name = "anonymous")
  player = Cutthroat::Player.new(name)
  callouts = mock
  callouts.stubs(:buy_property?).returns(false)
  player.register_callouts(callouts)
  player
end
