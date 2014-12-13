require 'yaml'

module Cutthroat
  class Board
    def initialize
      input = YAML.parse(DEFAULT_BOARD).to_ruby
      @locations = []
      input.each {|pos, value|
        if (value.nil?)
          @locations[pos] = Location.new(pos)
        else
          @locations[pos] = Location.new(pos, value)
        end
      }
      @locations.each { |l| l.board = self }
    end

    def locations
      @locations.length
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
0:
    name: Go
    type: go
1:
    name: Mediterranean Avenue
    rent: [2, 10, 30, 90, 160, 250]
    land_price: 60
    group: street1
2:
    name: Community Chest
3:
    name: Baltic Avenue
    house_price: 50
    group: street1
4:
    name: Income Tax
    action: income_tax
5:
    name: Reading Railroad
    rent: 25
    land_price: 200
    group: railroad
6:
    name: Oriental Avenue
    rent: [6, 30, 90, 270, 400, 550]
    land_price: 100
    group: street2
7:
    name: Chance
    action: chance
8:
    name: Vermont Avenue
    rent: [6, 30, 90, 270, 400, 550]
    house_price: 50
    group: street2
9:
    name: Connecticut Avenue
    group: street2
10:
    name: Just Visiting
    type: jail
11:
12:
    name: Electric Company
    group: utility
13:
    name: States Avenue
    group: street3
    land_price: 140
14:
    name: Virginia Avenue
    land_price: 160
15:
    name: Pennsylvania Railroad
    rent: 25
    group: railroad
16:
    name: St. James Place
17:
18:
    name: Tennessee Avenue
    land_price: 180
19:
    name: New York Avenue
    house_price: 100
20:
    name: Free Parking
21:
    name: Kentucky Avenue
    land_price: 220
    house_price: 150
22:
23:
24:
    name: Illinois Avenue
    rent: [20, 100, 300, 750, 925, 1100]
    group: street5
25:
    name: B&O RR
    rent: 25
    group: railroad
26:
27:
    name: Ventnor Avenue
    land_price: 260
    rent: [22, 110, 330, 800, 975, 1150]
    group: street6
28:
    name: Water Works
    group: utility
29:
30:
    name: Go To Jail
    action: put_in_jail
31:
    name: Pacific Avenue
    rent: [26, 130, 390, 900, 1100, 1275]
    group: street7
32:
    name: North Carolina Avenue
33:
34:
    name: Pennsylvania Avenue
35:
    name: Short Line
    rent: 25
    group: railroad
36:
37:
    name: Park Place
    rent: [35, 175, 500, 1100, 1300, 1500]
    land_price: 350
    group: street8
38:
    name: Luxury Tax
    action: luxury_tax
39:
    name: Boardwalk
    rent: [50, 200, 600, 1400, 1700, 2000]
    group: street8
ENDOFBOARD

