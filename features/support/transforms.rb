
LOCATION = Transform /^'([^']+)'$/ do |number|
  board.lookup(number)
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

