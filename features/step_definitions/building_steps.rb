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
  expect(location.houses).to eq(count)
end

Then /^on (#{LOCATION}) stands one hotel$/ do |location|
  expect(location.hotels).to eq(1)
end

When /^the player tries to( buy| sell) a( house| hotel) for (#{LOCATION})$/ do |trade, building, location|
  expect {
    player_trades_with_bank("#{trade.strip}_#{building.strip}".to_sym, location)
  }.to raise_error(Cutthroat::PropertyError) { |error|
    save_last_message error.message
  }
end

Given /^a player owns the following set of houses:$/ do |properties|
  # properties is a Cucumber::Ast::Table
  properties.map_column!('Houses') {|h| h.to_i }
  properties.map_column!('Street') {|s| board.lookup(s) }
  properties.rows.each do |p|
    p[0].set_owner(player)
    p[0].instance_variable_set('@buildings', p[1])
  end
end

Given /^the bank has a remaining stock of zero( houses| hotels)$/ do |building|
  b = "@remaining_#{building.strip}"
  game.instance_variable_set(b, 0)
end
