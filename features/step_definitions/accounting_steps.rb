Then /^the balance of this player is increased by \$(\d+)$/ do |amount|
  player.balance.should == balance_of[player] + amount
end

Then /^the balance of this player is unchanged$/ do
  player.balance.should == balance_of[player]
end

Given /^a player with a total worth of \$(\d+)$/ do |amount|
  start_game_with_two_player
  set_worth_of_player_to(amount.to_i)
end

Then /^the balance of this player is decreased by \$(\d+)$/ do |amount|
  player.balance.should == balance_of[player] - amount
end

Then /^the balance of this player is decreased by cost of property$/ do
  player.balance.should == balance_of[player] - location.land_price
end

Then /^(#{PLAYER}) pays \$(\d+) rent to (#{PLAYER})$/ do |charged_player, amount, advantaged_player|
  charged_player.balance.should == balance_of[charged_player] - amount
  advantaged_player.balance.should == balance_of[advantaged_player] + amount
end

Then /^(#{PLAYER}) pays (#{NUMBER})x current dice rent to (#{PLAYER})$/ do |charged_player, times, advantaged_player|
  eyes = charged_player.last_throw.inject(:+)

  charged_player.balance.should == balance_of[charged_player] - (times * eyes)
  advantaged_player.balance.should == balance_of[advantaged_player] + (times * eyes)
end

Then /^(#{PLAYER}) pays (twice )?the stated rent to (#{PLAYER})$/ do |charged_player, twice, advantaged_player|
  rent = charged_player.location.rent[charged_player.location.buildings]
  rent *= 2 unless twice.nil?

  charged_player.balance.should == balance_of[charged_player] - rent
  advantaged_player.balance.should == balance_of[advantaged_player] + rent
end

Then /^the balance of (#{PLAYER}) is increased by mortgage rate of (#{LOCATION})$/ do |player, location|
  player.balance.should == balance_of[player] +
    location.land_price * Cutthroat::MORTGAGE_RATE / 100
end

Then /^the balance of (#{PLAYER}) is unchanged$/ do |player|
  player.balance.should == balance_of[player]
end

Then /^the balance of (#{PLAYER}) is decreased by discharge of mortgage of (#{LOCATION})$/ do |player, location|
  player.balance.should == balance_of[player] -
    (location.land_price * (Cutthroat::MORTGAGE_RATE + Cutthroat::MORTGAGE_DUTY) / 100)
end

Then /^the balance of this player is decreased by the fee$/ do
  player.balance.should == balance_of[player] - Cutthroat::JAIL_FEE
end

Then /^the player is charged by the price of a house on (#{LOCATION})$/ do |location|
  player.balance.should == balance_of[player] - location.house_price
end

Then /^the player receives half of the price of a house on (#{LOCATION})$/ do |location|
  player.balance.should == balance_of[player] + (location.house_price / 2)
end
