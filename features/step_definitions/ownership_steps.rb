Given /^(#{LOCATION}) is unowned$/ do |location|
  location.set_owner nil
end

Then /^(#{LOCATION}) is still unowned$/ do |location|
  expect(location.owner).to be_nil
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
  expect(location.owner).to be player
end

Given /^(#{PLAYER}) owns (#{LOCATION})(?: with (#{NUMERAL}) houses?)?$/ do |name, location, count|
  balance_of[name] = name.balance
  location.set_owner name
  if count
    location.instance_variable_set('@buildings', count.to_i)
  end
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

Given /^he owns all other properties in the group of (#{LOCATION}) with (#{NUMERAL}) houses$/ do |location, count|
  board.all_of_group(location.group).map {|l|
    l.set_owner player
    l.instance_variable_set('@buildings', count.to_i) unless l == location
  }
end

Given /^a player owns all properties in the group of (#{LOCATION})$/ do |location|
  board.all_of_group(location.group).map {|l|
    l.set_owner player
  }
end

Given /^(#{LOCATION}) is owned by another player$/ do |location|
  location.set_owner(new_player("abcde"))
end
