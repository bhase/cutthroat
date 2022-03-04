Then('{player} should receive a message {string}') do |player, message|
  expect(last_error_message).to match(/#{message}/)
end
