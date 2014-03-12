Then /^the player shall end on (#{LOCATION})$/ do |location|
  player.location.should equal location
end

When /^the player lands on (#{LOCATION})$/ do |location|
  balance_of[player] = player.balance
  play_turn_and_land_on(location)
end

Given /^a player on (#{LOCATION})$/ do |location|
  start_game_with_two_player
  balance_of[player] = player.balance
  player.move_to(location)
end

When /^the player leaves Go$/ do
  balance_of[player] = player.balance
  dice.should_receive(:roll).and_return([3,2])
  play_turn_from(board.find_go)
end

When /^the player passes (?:over )?(#{LOCATION})$/ do |location|
  balance_of[player] = player.balance
  play_turn_and_pass_over(location)
end

When /^the player moves without touching 'Go'$/ do
  balance_of[player] = player.balance
  dice.should_receive(:roll).and_return([3,2])
  play_turn_from(board.lookup(17))
end

When /^(#{NAME}) lands on (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  play_turn_and_land_on(location, player)
end

When /^the player passes 'Go' twice during his turn$/ do
  balance_of[player] = player.balance
  dice.should_receive(:roll).and_return([3,5])
  play_turn_from(board.lookup(39)) # land on chance
  # TODO need to prepare chance later
end
