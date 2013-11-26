Then /^all players shall have played the same number of turns$/ do
  game.players.each do |player|
    player.turns_played.should eq(game.players[0].turns_played)
  end
end

Then /^in each round the player order has been equal to the iniial order$/ do
  player_list_at_round.each do |players|
    players.should eq player_list_at_round[0]
  end
end

Then /^'(#{NAME})' and '(#{NAME})' both have been the starting player$/ do |name1, name2|
  initial_players[name1].should_not eq(0), "#{name1} was not starting player!"
  initial_players[name2].should_not eq(0), "#{name2} was not starting player!"
end
