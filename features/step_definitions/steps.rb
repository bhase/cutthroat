module KnowsPlayer
  def player
    @player ||= Cutthroat::Player.new()
  end
end

module KnowsGame
  def game
    @game ||= Cutthroat::Game.new()
  end
end

World(KnowsPlayer)
World(KnowsGame)

LOCATION = Transform /^\d+$/ do |number|
  number.to_i
end

EYES = Transform /^\d+$/ do |number|
  number.to_i
end

Given /^a player on location (#{LOCATION})$/ do |location|
  player.move_to(location)
  player.location.should == location
end

When /^the player rolls (#{EYES})$/ do |eyes|
  dices = double()
  dices.should_receive(:roll).twice.and_return((eyes/2.0).floor, (eyes/2.0).ceil)
  player.play_turn(dices)
end

Then /^the player shall end on location (#{LOCATION})$/ do |location|
  player.location.should == location
end

Given /^two player named '(\w+)' and '(\w+)' added to a game$/ do |name1, name2|
  player1 = Cutthroat::Player.new(name1)
  player2 = Cutthroat::Player.new(name2)
  game.add_player(player1)
  game.add_player(player2)
  game.players.length.should == 2
end

When /^I start a game(?: (\d+) times)?$/ do |arg1|
  game.start
  game.active.should == true
end

Then /^a game with '(\w+)' and '(\w+)' should exist$/ do |name1, name2|
  game.players.select {|player| player.name == name1 }.length.should == 1
  game.players.select {|player| player.name == name2 }.length.should == 1
end

Given /^one player added to a game$/ do
  game.add_player(player)
  game.players.length.should == 1
end

When /^I try to start a game$/ do
  lambda { game.start }.should raise_error(Cutthroat::TooFewPlayerError) { |error|
    @last_error_message = error.message }
end

Then /^I should receive a message '(.+)'$/ do |message|
  @last_error_message.should match(/#{message}/)
end

Then /^no game exists$/ do
  game.active.should be false
end

Given /^eight player added to a game$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^'Horse' and 'Car' both have been the starting player$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I try to add another player$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the game has eight player$/ do
  pending # express the regexp above with the code you wish you had
end
