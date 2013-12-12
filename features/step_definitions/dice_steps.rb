When /^the player rolls (#{EYES})$/ do |eyes|
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
  sequence.raw.each do |s|
    roll_sequence << eval(s[0])
  end
  dice.should_receive(:roll).and_return(*roll_sequence)
  player.play_turn(dice)
end
