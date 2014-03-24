When /^the player rolls (#{NUMBER})$/ do |eyes|
  setup_dice_for(eyes)
  player.play_turn(dice)
end

When /^the player rolls enough to land on (#{LOCATION})$/ do |location|
  goal = location.to_i - player.location.to_i
  setup_dice_for(goal)
  player.play_turn(dice)
end

When /^the player rolls the following sequence$/ do |sequence|
  # sequence is a Cucumber::Ast::Table
  roll_sequence = []
  sum = 0
  sequence = sequence.map_headers("Eyes rolled" => :cast, "Turn played?" => :played)
  sequence.hashes.each do |s|
    roll = eval(s[:cast])
    sum += roll.inject(:+)
    if s[:played] == "no"
      fail_if_pos_reached(player.location.to_i + sum)
    end
    roll_sequence << roll
  end
  dice.should_receive(:roll).at_most(3).times.and_return(*roll_sequence)
  player.play_turn(dice)
end
