Then /^(?:I|#{NAME}) should receive a message '(.+)'$/ do |message|
  @last_error_message.should match(/#{message}/)
end
