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

Given /^(#{PLAYER}) owns (#{LOCATION})$/ do |name, location|
  balance_of[name] = name.balance
  location.owner = name
end

Given /^(#{PLAYER}) owns these properties$/ do |name, properties|
  # properties is a Cucumber::Ast::Table
  balance_of[name] = name.balance
  properties.raw.each do |property|
    board.lookup(property[0]).owner = name
  end
end

