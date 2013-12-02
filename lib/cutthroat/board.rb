require 'yaml'

module Cutthroat
  class Board
    def initialize
      @locations = YAML.parse(DEFAULT_BOARD).to_ruby
    end

    def lookup(location)
      @locations.find {|l| l.position == location || l.name == location }
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
    name: Income Tax
- !ruby/object:Cutthroat::Location
    position: 5
    name: Reading Railroad
- !ruby/object:Cutthroat::Location
    position: 6
    name: Oriental Avenue
- !ruby/object:Cutthroat::Location
    position: 7
- !ruby/object:Cutthroat::Location
    position: 10
    name: Just Visiting
- !ruby/object:Cutthroat::Location
    position: 11
- !ruby/object:Cutthroat::Location
    position: 12
- !ruby/object:Cutthroat::Location
    position: 14
    name: Virginia Avenue
- !ruby/object:Cutthroat::Location
    position: 15
- !ruby/object:Cutthroat::Location
    position: 19
    name: New York Avenue
- !ruby/object:Cutthroat::Location
    position: 20
- !ruby/object:Cutthroat::Location
    position: 25
    name: B&O RR
    type: !ruby/sym property
- !ruby/object:Cutthroat::Location
    position: 30
    name: Go To Jail
- !ruby/object:Cutthroat::Location
    position: 32
    name: North Carolina Avenue
- !ruby/object:Cutthroat::Location
    position: 35
- !ruby/object:Cutthroat::Location
    position: 37
- !ruby/object:Cutthroat::Location
    position: 38
    name: Luxury Tax
- !ruby/object:Cutthroat::Location
    position: 39
    name: Boardwalk
ENDOFBOARD

