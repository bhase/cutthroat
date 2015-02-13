Then /^(?:I|#{PLAYER}) should receive a message '(.+)'$/ do |message|
  expect(last_error_message).to match(/#{message}/)
end
