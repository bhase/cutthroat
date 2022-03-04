ParameterType(
  name: 'building',
  regexp: /(house(?:s)?|hotel(?:s)?)/,
  transformer: -> (name) { name },
)

ParameterType(
  name: 'trade',
  regexp: /buy|sell/,
  transformer: -> (trade) { trade },
)

ParameterType(
  name: 'player',
  regexp: /\w+/,
  transformer: -> (player) { find_player_by_name(player) },
  use_for_snippets: false
)

ParameterType(
  name: 'location',
  regexp: /'([^']*)'/,
  transformer: -> (location) { board.lookup(location) },
)

ParameterType(
  name: 'numeral',
  regexp: /((?:one)|(?:no)|(?:none)|(?:two)|(?:four)|(?:zero))/,
  transformer: -> (numeral) {
  case numeral
  when "no" || "none" || "zero"
    0
  when "one"
    1
  when "two"
    2
  when "four"
    4
  end
  },
)
