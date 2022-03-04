
When('{player} mortgages {location}') do |name, location|
  player_trades_with_bank(:mortgage, location, name)
end

Then('{location} shall be mortgaged') do |location|
  expect(location.is_mortgaged).to eq true
end

Given('{location} is (already) mortgaged') do |location|
  location.mortgage(location.owner)
  expect(location.is_mortgaged).to eq true
end

When('{player} tries to mortgage {location}') do |name, location|
  expect {
    player_trades_with_bank(:mortgage, location, name)
  }.to raise_error(Cutthroat::MortgageError) { |error|
    save_last_message error.message
  }
end

When('{player} repays the mortgage for {location}') do |name, location|
  player_trades_with_bank(:cancel_mortgage, location, name)
end

Then('{location} is no longer mortgaged') do |location|
  expect(location.is_mortgaged).to eq false
end

When('{player} tries to repay the mortgage for {location}') do |name, location|
  expect {
    player_trades_with_bank(:cancel_mortgage, location, name)
  }.to raise_error(Cutthroat::MortgageError) { |error|
    save_last_message error.message
  }
end

