require 'yaml'

module Cutthroat
  class Board
    def initialize
      @locations = YAML.parse(DEFAULT_BOARD).to_ruby
    end

    def lookup(location)
      @locations.find {|l| l.position == location || l.name == location }
    end

    def find_jail
      @locations.find {|l| l.type.nil? == false && l.type.to_sym == :jail}
    end

    def find_go
      @locations.find {|l| l.type.nil? == false && l.type.to_sym == :go}
    end

    def all_owned_by(player)
      @locations.select {|l| l.owner == player }
    end

    def all_of_group(group)
      @locations.select {|l| l.group == group }
    end

  end
end

Cutthroat::DEFAULT_BOARD = <<ENDOFBOARD
---
- !ruby/object:Cutthroat::Location
    position: 0
    name: Go
    type: go
- !ruby/object:Cutthroat::Location
    position: 1
    name: Mediterranean Avenue
    rent: 2
    land_price: 60
    group: !ruby/sym street1
- !ruby/object:Cutthroat::Location
    position: 2
    name: Community Chest
- !ruby/object:Cutthroat::Location
    position: 3
    name: Baltic Avenue
    group: !ruby/sym street1
- !ruby/object:Cutthroat::Location
    position: 4
    name: Income Tax
    action: income_tax
- !ruby/object:Cutthroat::Location
    position: 5
    name: Reading Railroad
    rent: 25
    land_price: 200
    group: !ruby/sym railroad
- !ruby/object:Cutthroat::Location
    position: 6
    name: Oriental Avenue
    rent: 6
    land_price: 100
    group: !ruby/sym street2
- !ruby/object:Cutthroat::Location
    position: 7
    name: Chance
    action: chance
- !ruby/object:Cutthroat::Location
    position: 8
    name: Vermont Avenue
    group: !ruby/sym street2
- !ruby/object:Cutthroat::Location
    position: 9
    name: Connecticut Avenue
    group: !ruby/sym street2
- !ruby/object:Cutthroat::Location
    position: 10
    name: Just Visiting
    type: jail
- !ruby/object:Cutthroat::Location
    position: 11
- !ruby/object:Cutthroat::Location
    position: 12
    name: Electric Company
    group: !ruby/sym utility
- !ruby/object:Cutthroat::Location
    position: 13
    name: States Avenue
    group: !ruby/sym street3
    land_price: 140
- !ruby/object:Cutthroat::Location
    position: 14
    name: Virginia Avenue
    land_price: 160
- !ruby/object:Cutthroat::Location
    position: 15
    name: Pennsylvania Railroad
    rent: 25
    group: !ruby/sym railroad
- !ruby/object:Cutthroat::Location
    position: 16
    name: St. James Place
- !ruby/object:Cutthroat::Location
    position: 18
    name: Tennessee Avenue
    land_price: 180
- !ruby/object:Cutthroat::Location
    position: 19
    name: New York Avenue
- !ruby/object:Cutthroat::Location
    position: 20
- !ruby/object:Cutthroat::Location
    position: 21
    name: Kentucky Avenue
- !ruby/object:Cutthroat::Location
    position: 22
- !ruby/object:Cutthroat::Location
    position: 24
    name: Illinois Avenue
    rent: 20
    group: !ruby/sym street5
- !ruby/object:Cutthroat::Location
    position: 25
    name: B&O RR
    rent: 25
    group: !ruby/sym railroad
- !ruby/object:Cutthroat::Location
    position: 27
    name: Ventnor Avenue
    land_price: 260
    rent: 22
    group: !ruby/sym street6
- !ruby/object:Cutthroat::Location
    position: 28
    name: Water Works
    group: !ruby/sym utility
- !ruby/object:Cutthroat::Location
    position: 30
    name: Go To Jail
    action: put_in_jail
- !ruby/object:Cutthroat::Location
    position: 31
    name: Pacific Avenue
    rent: 26
    group: !ruby/sym street7
- !ruby/object:Cutthroat::Location
    position: 32
    name: North Carolina Avenue
- !ruby/object:Cutthroat::Location
    position: 34
    name: Pennsylvania Avenue
- !ruby/object:Cutthroat::Location
    position: 35
    name: Short Line
    rent: 25
    group: !ruby/sym railroad
- !ruby/object:Cutthroat::Location
    position: 36
- !ruby/object:Cutthroat::Location
    position: 37
    name: Park Place
    rent: 35
    land_price: 350
    group: !ruby/sym street8
- !ruby/object:Cutthroat::Location
    position: 38
    name: Luxury Tax
    action: luxury_tax
- !ruby/object:Cutthroat::Location
    position: 39
    name: Boardwalk
    rent: 50
    group: !ruby/sym street8
ENDOFBOARD

