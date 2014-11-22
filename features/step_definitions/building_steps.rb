Given /^(#{PLAYER}) has built a house on (#{LOCATION})$/ do |name, location|
  location.instance_variable_set('@buildings', 1)
end

Given /^a player owns (#{NUMERAL}) house on (#{LOCATION})$/ do |count, location|
  location.instance_variable_set('@buildings', count)
end

When /^the player decides to buy a house for (#{LOCATION})$/ do |location|
  balance_of[player] = player.balance
  game.add_player(player)
  callouts = double(:buy_property? => false)
  allow(callouts).to receive(:pre_hook).and_return([:buy_house, location], :roll_dice)
  player.register_callouts(callouts)
  game.play_round
end

When /^the player decides to sell a house from (#{LOCATION})$/ do |location|
  balance_of[player] = player.balance
  game.add_player(player)
  callouts = double(:buy_property? => false)
  allow(callouts).to receive(:pre_hook).and_return([:sell_house, location], :roll_dice)
  player.register_callouts(callouts)
  game.play_round
end

Then /^on (#{LOCATION}) stands (#{NUMERAL}) house$/ do |location, count|
  location.buildings.should == count
end
