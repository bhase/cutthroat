Then /^the player shall end in jail$/ do
  player.location.should equal board.find_jail
end

Then /^the player is in jail\.$/ do
  player.in_jail.should == true
end

