Then /^the player shall end on (#{LOCATION})$/ do |location|
  player.location.should equal location
end

When /^the player lands on 'Go'$/ do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,2])
  play_turn_from(board.lookup(35))
end

Given /^a player on (#{LOCATION})$/ do |location|
  start_a_game
  @initial_balance = player.balance
  player.move_to(location)
end

When /^the player leaves Go$/ do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,2])
  player.play_turn(dice)
end

When /^the player passes 'Go'$/ do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,5])
  play_turn_from(board.lookup(35))
end

When /^the player passes over 'Income Tax'$/ do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([1,2])
  play_turn_from(board.lookup(3))
end

When /^the player lands on 'Income Tax'$/ do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([1,2])
  play_turn_from(board.lookup(1))
end

When /^the player moves without touching 'Go'$/ do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,2])
  play_turn_from(board.lookup(17))
end

