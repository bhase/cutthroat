Given /^(#{LOCATION}) is unowned$/ do |location|
  location.owner = nil
end

Then /^(#{LOCATION}) is still unowned$/ do |location|
  location.owner.should be nil
end

Given /^(#{LOCATION}) is owned by player$/ do |location|
  location.owner = player
end

When /^the player decides to buy this property$/ do
  balance_of[player] = player.balance
  location.record_rights(player)
end

Then /^the player owns (#{LOCATION})$/ do |location|
  location.owner.should be player
end

Given /^(#{NAME}) owns (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  location.owner = player
end

Given /^(#{NAME}) owns these properties$/ do |name, properties|
  # properties is a Cucumber::Ast::Table
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  properties.raw.each do |property|
    board.lookup(property[0]).owner = player
  end
end

