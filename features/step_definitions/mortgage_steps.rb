
When /^(#{PLAYER}) mortgages (#{LOCATION})$/ do |player, location|
  player.mortgage(location)
end

Then /^(#{LOCATION}) shall be mortgaged$/ do |location|
  location.is_mortgaged.should eq true
end

Given /^(#{LOCATION}) is (?:already )?mortgaged$/ do |location|
  location.mortgage(location.owner)
  location.is_mortgaged.should eq true
end

When /^(#{PLAYER}) tries to mortgage (#{LOCATION})$/ do |player, location|
  balance_of[player] = player.balance
  lambda { location.mortgage(player) }.should raise_error(Cutthroat::MortgageError) { |error|
    save_last_message error.message
  }
end

When /^(#{PLAYER}) repays the mortgage for (#{LOCATION})$/ do |player, location|
  balance_of[player] = player.balance
  location.cancel_mortgage(player)
end

Then /^(#{LOCATION}) is no longer mortgaged$/ do |location|
  location.is_mortgaged.should eq false
end

When /^(#{PLAYER}) tries to repay the mortgage for (#{LOCATION})$/ do |player, location|
  balance_of[player] = player.balance
  lambda { location.cancel_mortgage(player) }.should raise_error(Cutthroat::MortgageError) { |error|
    save_last_message error.message
  }
end

