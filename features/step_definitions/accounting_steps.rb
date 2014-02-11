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

Then /^(#{NAME}) pays (#{NUMBER})x current dice rent to (#{NAME})$/ do |sender, times, receiver|
  charged_player = find_player_by_name(sender)
  advantaged_player = find_player_by_name(receiver)
  eyes = charged_player.last_throw.inject(:+)

  charged_player.balance.should == balance_of[sender] - (times * eyes)
  advantaged_player.balance.should == balance_of[receiver] + (times * eyes)
end

Then /^(#{NAME}) pays (twice )?the stated rent to (#{NAME})$/ do |charged_name, twice, advantaged_name|
  charged_player = find_player_by_name(charged_name)
  advantaged_player = find_player_by_name(advantaged_name)
  rent = charged_player.location.rent
  rent *= 2 unless twice.nil?

  charged_player.balance.should == balance_of[charged_name] - rent
  advantaged_player.balance.should == balance_of[advantaged_name] + rent
end

Then /^the balance of (#{NAME}) is increased by (\d+)% of price of (#{LOCATION})$/ do |name, percentage, location|
  player = find_player_by_name(name)
  player.balance.should == balance_of[name] + location.land_price * percentage / 100
end

Then /^the balance of (#{NAME}) is unchanged$/ do |name|
  player = find_player_by_name(name)
  player.balance.should == balance_of[name]
end

Then /^the balance of (#{NAME}) is decreased by price of (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  player.balance.should == balance_of[name] - location.land_price 
end
