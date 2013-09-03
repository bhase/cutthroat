
LOCATION = Transform /^\d+$/ do |number|
  number.to_i
end

EYES = Transform /^\d+$/ do |number|
  number.to_i
end

NAME = Transform /^\w+$/ do |name|
  name
end

NUMBER = Transform /^\d+$/ do |number|
  number.to_i
end

