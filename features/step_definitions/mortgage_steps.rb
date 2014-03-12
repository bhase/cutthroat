
When /^(#{NAME}) mortgages (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  player.mortgage(location)
end

Then /^(#{LOCATION}) shall be mortgaged$/ do |location|
  location.is_mortgaged.should eq true
end

Given /^(#{LOCATION}) is (?:already )?mortgaged$/ do |location|
  location.mortgage(location.owner)
  location.is_mortgaged.should eq true
end

When /^(#{NAME}) tries to mortgage (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  lambda { location.mortgage(player) }.should raise_error(Cutthroat::MortgageError) { |error|
    save_last_message error.message
  }
end

When /^(#{NAME}) repays the mortgage for (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  location.cancel_mortgage(player)
end

Then /^(#{LOCATION}) is no longer mortgaged$/ do |location|
  location.is_mortgaged.should eq false
end

When /^(#{NAME}) tries to repay the mortgage for (#{LOCATION})$/ do |name, location|
  player = find_player_by_name(name)
  balance_of[name] = player.balance
  lambda { location.cancel_mortgage(player) }.should raise_error(Cutthroat::MortgageError) { |error|
    save_last_message error.message
  }
end

