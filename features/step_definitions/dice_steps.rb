When('the player rolls {int}') do |eyes|
  setup_dice_for(eyes)
  game.play_turn(player)
end

When('the player rolls enough to land on {location}') do |location|
  goal = location.to_i - player.location.to_i
  setup_dice_for(goal)
  game.play_turn(player)
end

When 'the player rolls the following sequence' do |sequence|
  # sequence is a Cucumber::Ast::Table
  roll_sequence = []
  sum = 0
  sequence = sequence.map_headers("Eyes rolled" => :cast, "Turn played?" => :played)
  sequence.hashes.each do |s|
    roll = eval(s[:cast])
    sum += roll.inject(:+)
    if s[:played] == "no"
      l = board.lookup((player.location.to_i + sum) % board.locations)
      expect(l).not_to receive(:trigger_action)
    end
    roll_sequence << roll
  end
  expect(dice).to receive(:roll).at_most(3).times.and_return(*roll_sequence)
  game.play_turn(player)
end

When 'the player rolls double' do
  expect(dice).to receive(:roll).twice.and_return([3, 3], [1, 3])
end

Then 'the player moves and rolls again' do
  game.play_round
  expect(player.location).to equal game.find_location(board.find_jail.to_i + 10)
end
