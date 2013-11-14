require 'yaml'

module Cutthroat
  class Board
    def initialize
      @locations = YAML.parse(DEFAULT_BOARD).to_ruby
    end

    def lookup(number)
      @locations[number]
    end

  end
end

Cutthroat::DEFAULT_BOARD = <<ENDOFBOARD
---
- !ruby/object:Cutthroat::Location
    position: 0
    name: Go
    type: !ruby/sym action
- !ruby/object:Cutthroat::Location
    position: 1
    name: Mediterranean Avenue
    type: !ruby/sym property
- !ruby/object:Cutthroat::Location
    position: 2
- !ruby/object:Cutthroat::Location
    position: 3
- !ruby/object:Cutthroat::Location
    position: 4
ENDOFBOARD

