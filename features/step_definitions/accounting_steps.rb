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

Then /^(#{NAME}) pays \$(\d+) rent to (#{NAME})$/ do |charged_name, amount, advantaged_name|
  charged_player = find_player_by_name(charged_name)
  advantaged_player = find_player_by_name(advantaged_name)

  charged_player.balance.should == balance_of[charged_name] - amount
  advantaged_player.balance.should == balance_of[advantaged_name] + amount
end

Then /^(#{NAME}) rolls dice and pays (#{NUMBER})x dice rent to (#{NAME})$/ do |sender, times, receiver|
  eyes = dice.roll.inject(:+) # works with stubbed dice
  charged_player = find_player_by_name(sender)
  advantaged_player = find_player_by_name(receiver)

  charged_player.balance.should == balance_of[sender] - (times * eyes)
  advantaged_player.balance.should == balance_of[receiver] + (times * eyes)
end
