When /^the player rolls (#{EYES})$/ do |eyes|
  dice.should_receive(:roll).and_return([(eyes/2.0).floor, (eyes/2.0).ceil])
  player.play_turn(dice)
end

Then /^the player shall end on (?:location )?(#{LOCATION})$/ do |location|
  player.location.should == location
end

Given /^two player named '(#{NAME})' and '(#{NAME})' added to a game$/ do |name1, name2|
  add_game_player(name1, name2)
  game.players.length.should == 2
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
    @last_error_message = error.message
  }
end

Then /^I should receive a message '(.+)'$/ do |message|
  @last_error_message.should match(/#{message}/)
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

Then /^'(#{NAME})' and '(#{NAME})' both have been the starting player$/ do |name1, name2|
  initial_players[name1].should_not eq(0), "#{name1} was not starting player!"
  initial_players[name2].should_not eq(0), "#{name2} was not starting player!"
end

When /^I try to add another player$/ do
  lambda { game.add_player(player) }.should raise_error(Cutthroat::TooManyPlayerError) { |error|
    @last_error_message = error.message
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

Given(/^a player in a game$/) do
  start_a_game
end

When(/^the player lands on 'Go'$/) do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,2])
  play_turn_from(35)
end

Then(/^the balance of this player is increased by \$(\d+)$/) do |amount|
  player.balance.should == @initial_balance + amount
end

When(/^the player moves without touching 'Go'$/) do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,2])
  play_turn_from(17)
end

Then(/^the balance of this player is unchanged$/) do
  player.balance.should == @initial_balance
end

Given(/^a player on (?:location )?(#{LOCATION})$/) do |location|
  start_a_game
  player.move_to(location)
end

When(/^the player leaves Go$/) do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,2])
  player.play_turn(dice)
end

When(/^the player passes 'Go'$/) do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([4,5])
  play_turn_from(35)
end
