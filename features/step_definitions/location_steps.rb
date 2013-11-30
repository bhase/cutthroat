Then /^the player shall end on (#{LOCATION})$/ do |location|
  player.location.should equal location
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

