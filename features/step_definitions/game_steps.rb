Given('two player named {string} and {string} added to a game') do |name1, name2|
  add_game_player(name1, name2)
  expect(game.players.length).to eq(2)
end

Given 'a player added to a game' do
  game.add_player(player)
end

Given 'a player in a game' do
  start_game_with_two_player
end

When 'I start a game' do
  game.start
end

Then('a game with {string} and {string} should exist') do |name1, name2|
  expect(game.players.select {|player| player.name == name1 }.length).to eq(1)
  expect(game.players.select {|player| player.name == name2 }.length).to eq(1)
end

Given 'one player added to a game' do
  game.add_player(player)
  expect(game.players.length).to eq(1)
end

When 'I try to start a game' do
  expect { game.start }.to raise_error(Cutthroat::TooFewPlayerError) { |error|
    save_last_message error.message
  }
end

Then 'no game exists' do
  expect(game.active).to eq(false)
end

Given('{int} player added to a game') do |number_of_players|
  number_of_players.times do |n|
    game.add_player(Cutthroat::Player.new("player#{n}"))
  end
  expect(game.players.length).to eq(number_of_players)
end

When('I start a game {int} times') do |count|
  count.times do
    game.start
    initial_players[game.players[0].name] += 1
  end
end

When('I try to add another player') do
  expect { game.add_player(player) }.to raise_error(Cutthroat::TooManyPlayerError) { |error|
    save_last_message error.message
  }
end

Then('the game has {int} player') do |number_of_players|
  expect(game.players.length).to eq(number_of_players)
end

Given 'a fresh started game' do
  start_game_with_two_player
  expect(game.active).to eq(true)
end

When('the game is cancelled after {int} rounds') do |rounds|
  rounds.times do
    game.play_round
    player_list_at_round << game.players
  end
  game.cancel
end
