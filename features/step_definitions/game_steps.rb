Given /^two player named '(#{NAME})' and '(#{NAME})' added to a game$/ do |name1, name2|
  add_game_player(name1, name2)
  game.players.length.should == 2
end

Given /^a player in a game$/ do
  start_a_game
end

When /^I start a game$/ do
  game.start
end

Then /^a game with '(#{NAME})' and '(#{NAME})' should exist$/ do |name1, name2|
  game.players.select {|player| player.name == name1 }.length.should == 1
  game.players.select {|player| player.name == name2 }.length.should == 1
end

Given /^one player added to a game$/ do
  game.add_player(player)
  game.players.length.should == 1
end

When /^I try to start a game$/ do
  lambda { game.start }.should raise_error(Cutthroat::TooFewPlayerError) { |error|
    save_last_message error.message
  }
end

Then /^no game exists$/ do
  game.active.should be false
end

Given /^(#{NUMBER}) player added to a game$/ do |number_of_players|
  number_of_players.times do |n|
    game.add_player(Cutthroat::Player.new("player#{n}"))
  end
  game.players.length.should eq(number_of_players)
end

When /^I start a game (#{NUMBER}) times$/ do |count|
  count.times do
    game.start
    initial_players[game.players[0].name] += 1
  end
end

When /^I try to add another player$/ do
  lambda { game.add_player(player) }.should raise_error(Cutthroat::TooManyPlayerError) { |error|
    save_last_message error.message
  }
end

Then /^the game has (#{NUMBER}) player$/ do |number_of_players|
  game.players.length.should eq(number_of_players)
end

Given /^a fresh started game$/ do
  start_a_game
  game.active.should be true
end

When /^the game is cancelled after (#{NUMBER}) rounds$/ do |rounds|
  rounds.times do
    game.play_round
    player_list_at_round << game.players
  end
  game.cancel
end
