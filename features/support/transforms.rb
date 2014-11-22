
LOCATION = Transform /^'([^']+)'$/ do |number|
  board.lookup(number)
end

NAME = Transform /^"(\w+)"$/ do |name|
  name
end

PLAYER = Transform /^\w+$/ do |name|
  find_player_by_name(name)
end

NUMBER = Transform /^\d+$/ do |number|
  number.to_i
end

NUMERAL = Transform /^((?:one)|(?:no)|(?:none)|(?:four))$/ do |numeral|
  case numeral
  when "no" || "none"
    0
  when "one"
    1
  end
end
