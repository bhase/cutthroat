Then /^the player shall end on (#{LOCATION})$/ do |location|
  player.location.should equal location
end

Then /^the player shall end in jail$/ do
  player.location.should equal game.find_location(10)
  # TODO check if player is in jail and did not just land here
end

When /^the player lands on (#{LOCATION})$/ do |location|
  @initial_balance = player.balance
  play_turn_and_land_on(location)
end

Given /^a player on (#{LOCATION})$/ do |location|
  start_a_game
  @initial_balance = player.balance
  player.move_to(location)
end

When /^the player leaves Go$/ do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,2])
  play_turn_from(board.lookup(0))
end

When /^the player passes (?:over )?(#{LOCATION})$/ do |location|
  @initial_balance = player.balance
  play_turn_and_pass_over(location)
end

When /^the player moves without touching 'Go'$/ do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,2])
  play_turn_from(board.lookup(17))
end

Given /^(#{LOCATION}) is unowned$/ do |location|
  location.owner = nil
end

Then /^(#{LOCATION}) is still unowned$/ do |location|
  location.owner.should be nil
end

Given /^(#{LOCATION}) is owned by player$/ do |location|
  location.owner = player
end

When /^the player decides to buy this property$/ do
  @initial_balance = player.balance
  location.record_rights(player)
end

Then /^the player owns (#{LOCATION})$/ do |location|
  location.owner.should be player
end

Given /^(#{NAME}) owns (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  location.owner = player
end

When /^(#{NAME}) lands on (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  play_turn_and_land_on(location, player)
end

Given /^(#{NAME}) owns these properties$/ do |name, properties|
  # properties is a Cucumber::Ast::Table
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  properties.raw.each do |property|
    board.lookup(property[0]).owner = player
  end
end

When /^(#{NAME}) mortgages (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  player.mortgage(location)
end

Then /^(#{LOCATION}) shall be mortgaged$/ do |location|
  location.is_mortgaged.should eq true
end

Given /^(#{LOCATION}) is (?:already )?mortgaged$/ do |location|
  location.mortgage(location.owner)
  location.is_mortgaged.should eq true
end

When /^(#{NAME}) tries to mortgage (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  lambda { location.mortgage(player) }.should raise_error(Cutthroat::MortgageError) { |error|
    @last_error_message = error.message
  }
end
