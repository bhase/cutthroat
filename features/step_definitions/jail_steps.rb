Then /^the player shall end in jail$/ do
  player.location.should equal board.find_jail
  player.in_jail.should == true
end

Then /^the player is in jail\.$/ do
  player.in_jail.should == true
end

Given /^a player in Jail$/ do
  game.add_player(player)
  player.arrest_at(board.find_jail)
end

When /^the player pays the Jail fee at begin of his turn$/ do
  balance_of[player] = player.balance
  callout = double(:buy_property? => false)
  expect(callout).to receive(:pre_hook).and_return(:pay_jail_fee, :roll_dice)
  player.register_callouts(callout)
  game.play_round
end

Then /^the player is no longer in Jail and moves on$/ do
  player.in_jail.should == false
  player.location.should_not equal board.find_jail
end

Then /^the player is still in Jail and does not move$/ do
  player.location.should equal board.find_jail
  player.in_jail.should == true
end

When /^the player rolls dice to leave jail and does not roll double$/ do
  game.play_round
end
