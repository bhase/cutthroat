When /^the player rolls (#{EYES})$/ do |eyes|
  setup_dice_for(eyes)
  player.play_turn(dice)
end

When /^the player rolls enough to land on (#{LOCATION})$/ do |location|
  goal = location.to_i - player.location.to_i
  setup_dice_for(goal)
  player.play_turn(dice)
end
