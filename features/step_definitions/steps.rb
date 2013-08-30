module KnowsPlayer
  def player
    @player ||= Cutthroat::Player.new()
  end
end

module KnowsGame
  def game
    @game ||= Cutthroat::Game.new()
  end

  def initial_players
    @initial_players ||= Hash.new(0)
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

When /^I start a game$/ do
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
    @last_error_message = error.message
  }
end

Then /^I should receive a message '(.+)'$/ do |message|
  @last_error_message.should match(/#{message}/)
end

Then /^no game exists$/ do
  game.active.should be false
end

Given /^(\d+) player added to a game$/ do |number_of_players|
  number_of_players.times do |n|
    game.add_player(Cutthroat::Player.new("player#{n}"))
  end
  game.players.length.should eq(number_of_players)
end

When /^I start a game (\d+) times$/ do |count|
  count.times do
    game.start
    initial_players[game.players[0].name] += 1
  end
end

Then /^'(\w+)' and '(\w+)' both have been the starting player$/ do |name1, name2|
  initial_players[name1].should_not eq(0), "#{name1} was not starting player!"
  initial_players[name2].should_not eq(0), "#{name2} was not starting player!"
end

When /^I try to add another player$/ do
  lambda { game.add_player(player) }.should raise_error(Cutthroat::TooManyPlayerError) { |error|
    @last_error_message = error.message
  }
end

Then /^the game has (\d+) player$/ do |number_of_players|
  game.players.length.should eq(number_of_players)
end

Given /^a fresh started game$/ do
  game.add_player(Cutthroat::Player.new("p1"))
  game.add_player(Cutthroat::Player.new("p2"))
  game.add_player(Cutthroat::Player.new("p3"))
  game.start
  game.active.should be true
end

When /^the game is cancelled after (\d+) rounds$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^all players shall have played the same number of turns$/ do
  pending # express the regexp above with the code you wish you had
end
