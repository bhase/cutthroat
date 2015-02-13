Then /^the player shall end in jail$/ do
  expect(player.location).to equal(board.find_jail)
  expect(player.in_jail).to eq(true)
end

Then /^the player is in jail\.$/ do
  expect(player.in_jail).to eq(true)
end

Given /^a player in Jail$/ do
  game.add_player(player)
  player.arrest_at(board.find_jail)
  balance_of[player] = player.balance
end

When /^the player pays the Jail fee at begin of his turn$/ do
  callout = double(:buy_property? => false)
  expect(callout).to receive(:pre_hook).and_return(:pay_jail_fee, :roll_dice)
  player.register_callouts(callout)
end

When /^rolls dice to continue his turn$/ do
  game.play_round
end

Then /^the player is no longer in Jail and moves on$/ do
  expect(player.in_jail).to eq(false)
  expect(player.location).not_to equal(board.find_jail)
end

Then /^the player is still in Jail and does not move$/ do
  expect(player.location).to equal(board.find_jail)
  expect(player.in_jail).to eq(true)
end

When /^the player rolls dice to leave jail and does not roll double$/ do
  game.play_round
end

When /^the player rolls dice to leave Jail and rolls double$/ do
  expect(dice).to receive(:roll).and_return([3, 3])
  game.play_round
end

When /^the player rolls dice and does not roll double for three turns$/ do
  3.times do
    game.play_round
  end
end

Then /^the player has to pay the Jail fee$/ do
  expect(player.balance).to eq(balance_of[player] - Cutthroat::JAIL_FEE)
end

Then /^moves with the eyes of the last throw$/ do
  expect(player.location).to equal(game.find_location(board.find_jail.to_i + player.last_throw.reduce(:+)))
end
