Then('the player shall end on {location}') do |location|
  expect(player.location).to equal(location)
end

When('the player lands on {location}') do |location|
  balance_of[player] = player.balance
  play_turn_and_land_on(location)
end

Given('a player on {location}') do |location|
  start_game_with_two_player
  balance_of[player] = player.balance
  player.move_to(location)
end

When 'the player leaves Go' do
  balance_of[player] = player.balance
  expect(dice).to receive(:roll).and_return([3,2])
  play_turn_from(board.find_go)
end

When('the player passes (over ){location}') do |location|
  balance_of[player] = player.balance
  play_turn_and_pass_over(location)
end

When "the player moves without touching 'Go'" do
  balance_of[player] = player.balance
  expect(dice).to receive(:roll).and_return([3,2])
  play_turn_from(board.lookup(17))
end

When ('{player} lands on {location}') do |name, location|
  balance_of[name] = name.balance
  play_turn_and_land_on(location, name)
end

When "the player passes 'Go' twice during his turn" do
  balance_of[player] = player.balance
  expect(dice).to receive(:roll).and_return([3,5])
  play_turn_from(board.lookup(39)) # land on chance
  # TODO need to prepare chance later
end
