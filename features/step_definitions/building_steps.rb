Given /^(#{PLAYER}) has built a house on (#{LOCATION})$/ do |name, location|
  location.instance_variable_set('@buildings', 1)
end
