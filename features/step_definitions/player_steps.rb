Then 'all players shall have played the same number of turns' do
  game.players.each do |player|
    expect(player.turns_played).to eq(game.players[0].turns_played)
  end
end

Then 'in each round the player order has been equal to the iniial order' do
  player_list_at_round.each do |players|
    expect(players).to eq player_list_at_round[0]
  end
end

Then('{string} and {string} both have been the starting player') do |name1, name2|
  expect(initial_players[name1]).not_to eq(0), "#{name1} was not starting player!"
  expect(initial_players[name2]).not_to eq(0), "#{name2} was not starting player!"
end
