Given('{location} is unowned') do |location|
  location.set_owner nil
end

Then('{location} is still unowned') do |location|
  expect(location.owner).to be_nil
end

Given('a player owns {location}') do |location|
  location.set_owner player
end

When('the player lands on {location} and decides to buy') do |location|
  balance_of[player] = player.balance
  player.register_callouts(double(:buy_property? => true))
  play_turn_and_land_on(location)
end

Then('the player owns {location}') do |location|
  expect(location.owner).to be player
end

Given('{player} owns {location}') do |name, location|
  balance_of[name] = name.balance
  location.set_owner name
end

Given('{player} owns {location} with {numeral} house(s)') do |name, location, count|
  balance_of[name] = name.balance
  location.set_owner name
  location.instance_variable_set('@buildings', count.to_i)
end

Given('{player} owns these properties') do |name, properties|
  # properties is a Cucumber::Ast::Table
  balance_of[name] = name.balance
  properties.raw.each do |property|
    board.lookup(property[0]).set_owner name
  end
end

Given('{player} owns all properties in the group of {location}') do |name, location|
  balance_of[name] = name.balance
  board.all_of_group(location.group).map {|l| l.set_owner name }
end

Given('{player} owns all other properties in the group of {location} with {numeral} houses') do |name, location, count|
  board.all_of_group(location.group).map {|l|
    l.set_owner name
    l.instance_variable_set('@buildings', count.to_i) unless l == location
  }
end

Given('a player owns all properties in the group of {location}') do |location|
  board.all_of_group(location.group).map {|l|
    l.set_owner player
  }
end

Given('{location} is owned by another player') do |location|
  location.set_owner(new_player("abcde"))
end
