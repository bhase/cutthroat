Given /^(#{LOCATION}) is unowned$/ do |location|
  location.set_owner nil
end

Then /^(#{LOCATION}) is still unowned$/ do |location|
  location.owner.should be nil
end

Given /^a player owns (#{LOCATION})$/ do |location|
  location.set_owner player
end

When /^the player lands on (#{LOCATION}) and decides to buy$/ do |location|
  balance_of[player] = player.balance
  player.register_callouts(double(:buy_property? => true))
  play_turn_and_land_on(location)
end

Then /^the player owns (#{LOCATION})$/ do |location|
  location.owner.should be player
end

Given /^(#{PLAYER}) owns (#{LOCATION})$/ do |name, location|
  balance_of[name] = name.balance
  location.set_owner name
end

Given /^(#{PLAYER}) owns these properties$/ do |name, properties|
  # properties is a Cucumber::Ast::Table
  balance_of[name] = name.balance
  properties.raw.each do |property|
    board.lookup(property[0]).set_owner name
  end
end

Given /^(#{PLAYER}) owns all properties in the group of (#{LOCATION})$/ do |name, location|
  balance_of[name] = name.balance
  board.all_of_group(location.group).map {|l| l.set_owner name }
end

Given /^he owns all other properties in the group of (#{LOCATION})$/ do |location|
  board.all_of_group(location.group).map {|l| l.set_owner player }
end

Given /^(#{LOCATION}) is owned by another player$/ do |location|
  location.set_owner(new_player("abcde"))
end
