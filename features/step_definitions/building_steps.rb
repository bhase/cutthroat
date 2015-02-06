Given /^(#{PLAYER}) has built a house on (#{LOCATION})$/ do |name, location|
  location.instance_variable_set('@buildings', 1)
end

Given /^a player owns (#{NUMERAL}) houses? on (#{LOCATION})$/ do |count, location|
  location.set_owner(player)
  location.instance_variable_set('@buildings', count)
end

Given /^a player owns one hotel on (#{LOCATION})$/ do |location|
  location.set_owner(player)
  location.instance_variable_set('@buildings', 5)
end

When /^the player decides to buy a house for (#{LOCATION})$/ do |location|
  player_trades_with_bank(:buy_house, location)
end

When /^the player decides to buy a hotel for (#{LOCATION})$/ do |location|
  player_trades_with_bank(:buy_hotel, location)
end

When /^the player decides to sell a house from (#{LOCATION})$/ do |location|
  player_trades_with_bank(:sell_house, location)
end

When /^the player decides to sell the hotel from (#{LOCATION})$/ do |location|
  player_trades_with_bank(:sell_hotel, location)
end

Then /^on (#{LOCATION}) stands? (#{NUMERAL}) houses?$/ do |location, count|
  location.houses.should == count
end

Then /^on (#{LOCATION}) stands one hotel$/ do |location|
  location.hotels.should == 1
end

When /^the player tries to buy a house for (#{LOCATION})$/ do |location|
  lambda {
    player_trades_with_bank(:buy_house, location)
  }.should raise_error(Cutthroat::NotOwnerOfAllInGroup) { |error|
    save_last_message error.message
  }
end
