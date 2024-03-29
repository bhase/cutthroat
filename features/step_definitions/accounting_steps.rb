Then 'the balance of this player is increased by ${int}' do |amount|
  expect(player.balance).to eq(balance_of[player] + amount)
end

Then 'the balance of this player is unchanged' do
  expect(player.balance).to eq(balance_of[player])
end

Given 'a player with a total worth of ${int}' do |amount|
  start_game_with_two_player
  set_worth_of_player_to(amount.to_i)
end

Then 'the balance of this player is decreased by ${int}' do |amount|
  expect(player.balance).to eq(balance_of[player] - amount)
end

Then 'the balance of this player is decreased by cost of property' do
  expect(player.balance).to eq(balance_of[player] - location.land_price)
end

Then('{player} pays ${int} rent to {player}') do |charged_player, amount, advantaged_player|
  expect(charged_player.balance).to eq(balance_of[charged_player] - amount)
  expect(advantaged_player.balance).to eq(balance_of[advantaged_player] + amount)
end

Then('{player} pays {int}x current dice rent to {player}') do |charged_player, times, advantaged_player|
  eyes = charged_player.last_throw.inject(:+)

  expect(charged_player.balance).to eq(balance_of[charged_player] - (times * eyes))
  expect(advantaged_player.balance).to eq(balance_of[advantaged_player] + (times * eyes))
end

Then('{player} pays {}the stated rent to {player}') do |charged_player, twice, advantaged_player|
  rent = charged_player.location.rent[charged_player.location.instance_variable_get('@buildings')]
  rent *= 2 unless twice.strip.empty?

  expect(charged_player.balance).to eq(balance_of[charged_player] - rent)
  expect(advantaged_player.balance).to eq(balance_of[advantaged_player] + rent)
end

Then('the balance of {player} is increased by mortgage rate of {location}') do |player, location|
  expect(player.balance).to eq(balance_of[player] +
    location.land_price * Cutthroat::MORTGAGE_RATE / 100)
end

Then('the balance of {player} is unchanged') do |player|
  expect(player.balance).to eq(balance_of[player])
end

Then('the balance of {player} is decreased by discharge of mortgage of {location}') do |player, location|
  expect(player.balance).to eq(balance_of[player] -
    (location.land_price * (Cutthroat::MORTGAGE_RATE + Cutthroat::MORTGAGE_DUTY) / 100))
end

Then 'the balance of this player is decreased by the fee' do
  expect(player.balance).to eq(balance_of[player] - Cutthroat::JAIL_FEE)
end

Then('the player is charged by the price of a house on {location}') do |location|
  expect(player.balance).to eq(balance_of[player] - location.house_price)
end

Then('the player receives half of the price of a house on {location}') do |location|
  expect(player.balance).to eq(balance_of[player] + (location.house_price / 2))
end
