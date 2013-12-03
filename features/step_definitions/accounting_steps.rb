Then /^the balance of this player is increased by \$(\d+)$/ do |amount|
  player.balance.should == @initial_balance + amount
end

Then /^the balance of this player is unchanged$/ do
  player.balance.should == @initial_balance
end

Given /^a player with a total worth of \$(\d+)$/ do |amount|
  start_a_game
  set_worth_of_player_to(amount.to_i)
end

Then /^the balance of this player is decreased by \$(\d+)$/ do |amount|
  player.balance.should == @initial_balance - amount
end

Then /^the balance of this player is decreased by cost of property$/ do
  player.balance.should == @initial_balance - location.land_price
end
