require 'yaml'

module Cutthroat
  class Board
    
    DEFAULT_BOARD = <<ENDOFBOARD
---
- !ruby/object:Cutthroat::Location
    id: 0
- !ruby/object:Cutthroat::Location
    id: 1
- !ruby/object:Cutthroat::Location
    id: 2
- !ruby/object:Cutthroat::Location
    id: 3
- !ruby/object:Cutthroat::Location
    id: 4
ENDOFBOARD

    def initialize
      @locations = YAML.parse(DEFAULT_BOARD).to_ruby
    end

    def lookup(number)
      @locations[number]
    end

  end
end
