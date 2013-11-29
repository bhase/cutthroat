Then /^the player shall end on (#{LOCATION})$/ do |location|
  player.location.should equal location
end

When /^the player lands on (#{LOCATION})$/ do |location|
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([1,2])
  if (location.to_i < 3)
    play_turn_from(board.lookup(40 - location.to_i - 3))
  else
    play_turn_from(board.lookup(location.to_i - 3))
  end
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

When /^the player passes (?:over )?(#{LOCATION})$/ do |location|
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([1,2])
  if (location.to_i < 3)
    play_turn_from(board.lookup(40 - location.to_i - 2))
  else
    play_turn_from(board.lookup(location.to_i - 2))
  end
end

When /^the player moves without touching 'Go'$/ do
  @initial_balance = player.balance
  dice.should_receive(:roll).and_return([3,2])
  play_turn_from(board.lookup(17))
end

