
When /^(#{PLAYER}) mortgages (#{LOCATION})$/ do |player, location|
  player_trades_with_bank(:mortgage, location, player)
end

Then /^(#{LOCATION}) shall be mortgaged$/ do |location|
  expect(location.is_mortgaged).to eq true
end

Given /^(#{LOCATION}) is (?:already )?mortgaged$/ do |location|
  location.mortgage(location.owner)
  expect(location.is_mortgaged).to eq true
end

When /^(#{PLAYER}) tries to mortgage (#{LOCATION})$/ do |player, location|
  expect {
    player_trades_with_bank(:mortgage, location, player)
  }.to raise_error(Cutthroat::MortgageError) { |error|
    save_last_message error.message
  }
end

When /^(#{PLAYER}) repays the mortgage for (#{LOCATION})$/ do |player, location|
  player_trades_with_bank(:cancel_mortgage, location, player)
end

Then /^(#{LOCATION}) is no longer mortgaged$/ do |location|
  expect(location.is_mortgaged).to eq false
end

When /^(#{PLAYER}) tries to repay the mortgage for (#{LOCATION})$/ do |player, location|
  expect {
    player_trades_with_bank(:cancel_mortgage, location, player)
  }.to raise_error(Cutthroat::MortgageError) { |error|
    save_last_message error.message
  }
end

