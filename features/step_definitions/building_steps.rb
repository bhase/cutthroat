Given /^(#{PLAYER}) has built a house on (#{LOCATION})$/ do |name, location|
  location.instance_variable_set('@buildings', 1)
end

When /^the player decides to buy a house for (#{LOCATION})$/ do |location|
  balance_of[player] = player.balance
  game.add_player(player)
  callouts = double(:buy_property? => false)
  allow(callouts).to receive(:pre_hook).and_return([:buy_house, location], :roll_dice)
  player.register_callouts(callouts)
  game.play_round
end

Then /^on (#{LOCATION}) stands one house$/ do |location|
  pending # express the regexp above with the code you wish you had
end
