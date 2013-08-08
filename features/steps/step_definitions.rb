module KnowsPlayer
  def player
    @player ||= Cutthroat::Player.new()
  end
end

World(KnowsPlayer)

LOCATION = Transform /^\d+$/ do |number|
  number.to_i
end

Given /^a player on location (#{LOCATION})$/ do |location|
  player.move_to(location)
  player.location.should == location
end

When /^the player rolls (\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the player shall end on location (\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
