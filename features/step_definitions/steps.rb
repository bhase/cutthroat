module KnowsPlayer
  def player
    @player ||= Cutthroat::Player.new()
  end
end

World(KnowsPlayer)

LOCATION = Transform /^\d+$/ do |number|
  number.to_i
end

EYES = Transform /^\d+$/ do |number|
  number.to_i
end

Given /^a player on location (#{LOCATION})$/ do |location|
  player.move_to(location)
  player.location.should == location
end

When /^the player rolls (#{EYES})$/ do |eyes|
  dices = double()
  dices.should_receive(:roll).twice.and_return((eyes/2.0).floor, (eyes/2.0).ceil)
  @player.play_turn(dices)
end

Then /^the player shall end on location (#{LOCATION})$/ do |location|
  @player.location.should == location
end
