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
  balance_of[player] = player.balance
end

When /^the player pays the Jail fee at begin of his turn$/ do
  callout = double(:buy_property? => false)
  expect(callout).to receive(:pre_hook).and_return(:pay_jail_fee, :roll_dice)
  player.register_callouts(callout)
end

When /^rolls dice to continue his turn$/ do
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

When /^the player rolls dice to leave Jail and rolls double$/ do
  dice.should_receive(:roll).and_return([3, 3])
  game.play_round
end

When /^the player rolls dice and does not roll double for three turns$/ do
  3.times do
    game.play_round
  end
end

Then /^the player has to pay the Jail fee$/ do
  player.balance.should == balance_of[player] - Cutthroat::JAIL_FEE
end

Then /^moves with the eyes of the last throw$/ do
  player.location.should equal game.find_location(board.find_jail.to_i + player.last_throw.reduce(:+))
end
