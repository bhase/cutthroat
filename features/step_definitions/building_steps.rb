Given '{player} has built a house on {location}' do |name, location|
  location.instance_variable_set('@buildings', 1)
end

Given('a player owns {numeral} house(s) on {location}') do |count, location|
  location.set_owner(player)
  location.instance_variable_set('@buildings', count)
end

Given('a player owns one hotel on {location}') do |location|
  location.set_owner(player)
  location.instance_variable_set('@buildings', 5)
end

When('the player decides to buy a house for {location}') do |location|
  player_trades_with_bank(:buy_house, location)
end

When('the player decides to buy a hotel for {location}') do |location|
  player_trades_with_bank(:buy_hotel, location)
end

When('the player decides to sell a house from {location}') do |location|
  player_trades_with_bank(:sell_house, location)
end

When('the player decides to sell the hotel from {location}') do |location|
  player_trades_with_bank(:sell_hotel, location)
end

Then('on {location} stand(s) {numeral} house(s)') do |location, count|
  expect(location.houses).to eq(count)
end

Then('on {location} stands one hotel') do |location|
  expect(location.hotels).to eq(1)
end

When('the player tries to {trade} a {building} for {location}') do |trade, building, location|
  expect {
    player_trades_with_bank("#{trade.strip}_#{building.strip}".to_sym, location)
  }.to raise_error(Cutthroat::PropertyError) { |error|
    save_last_message error.message
  }
end

Given 'a player owns the following set of houses:' do |properties|
  # properties is a Cucumber::Ast::Table
  properties.map_column!('Houses') {|h| h.to_i }
  properties.map_column!('Street') {|s| board.lookup(s) }
  properties.rows.each do |p|
    p[0].set_owner(player)
    p[0].instance_variable_set('@buildings', p[1])
  end
end

Given('the bank has a remaining stock of {numeral} {building}') do |count, building|
  b = "@remaining_#{building.strip}"
  game.instance_variable_set(b, count.to_i)
end
