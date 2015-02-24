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
    house_price: 20
    group: street1
2:
    name: Community Chest
3:
    name: Baltic Avenue
    rent: [4, 20, 60, 180, 320, 450]
    land_price: 60
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
    house_price: 50
    group: street2
7:
    name: Chance
    action: chance
8:
    name: Vermont Avenue
    rent: [6, 30, 90, 270, 400, 550]
    land_price: 100
    house_price: 50
    group: street2
9:
    name: Connecticut Avenue
    rent: [8, 40, 100, 300, 450, 600]
    land_price: 120
    house_price: 50
    group: street2
10:
    name: Just Visiting
    type: jail
11:
    name: St. Charles Place
    rent: [10, 50, 150, 450, 625, 750]
    land_price: 140
    house_price: 100
    group: street3
12:
    name: Electric Company
    group: utility
13:
    name: States Avenue
    rent: [10, 50, 150, 450, 625, 750]
    land_price: 140
    house_price: 100
    group: street3
14:
    name: Virginia Avenue
    rent: [12, 60, 180, 500, 700, 900]
    land_price: 160
    house_price: 100
    group: street3
15:
    name: Pennsylvania Railroad
    rent: 25
    group: railroad
16:
    name: St. James Place
    rent: [14, 70, 200, 550, 750, 950]
    land_price: 180
    house_price: 100
    group: street4
17:
    name: Community Chest
18:
    name: Tennessee Avenue
    rent: [14, 70, 200, 550, 750, 950]
    land_price: 180
    house_price: 100
    group: street4
19:
    name: New York Avenue
    rent: [16, 80, 220, 600, 800, 1000]
    land_price: 200
    house_price: 100
    group: street4
20:
    name: Free Parking
21:
    name: Kentucky Avenue
    rent: [18, 90, 250, 700, 875, 1050]
    land_price: 220
    house_price: 150
    group: street5
22:
    name: Chance
23:
    name: Indiana Avenue
    rent: [18, 90, 250, 700, 875, 1050]
    land_price: 220
    house_price: 150
    group: street5
24:
    name: Illinois Avenue
    rent: [20, 100, 300, 750, 925, 1100]
    land_price: 240
    house_price: 150
    group: street5
25:
    name: B&O RR
    rent: 25
    group: railroad
26:
    name: Atlantic Avenue
    rent: [22, 110, 330, 800, 975, 1150]
    land_price: 260
    house_price: 150
    group: street6
27:
    name: Ventnor Avenue
    rent: [22, 110, 330, 800, 975, 1150]
    land_price: 260
    house_price: 150
    group: street6
28:
    name: Water Works
    group: utility
29:
    name: Marvin Gardens
    rent: [24, 120, 360, 850, 1025, 1200]
    land_price: 280
    house_price: 150
    group: street6
30:
    name: Go To Jail
    action: put_in_jail
31:
    name: Pacific Avenue
    rent: [26, 130, 390, 900, 1100, 1275]
    land_price: 300
    house_price: 200
    group: street7
32:
    name: North Carolina Avenue
    rent: [26, 130, 390, 900, 1100, 1275]
    land_price: 300
    house_price: 200
    group: street7
33:
    name: Community Chest
34:
    name: Pennsylvania Avenue
    rent: [28, 150, 450, 1000, 1200, 1400]
    land_price: 320
    house_price: 200
35:
    name: Short Line
    rent: 25
    group: railroad
36:
    name: Chance
37:
    name: Park Place
    rent: [35, 175, 500, 1100, 1300, 1500]
    land_price: 350
    house_price: 200
    group: street8
38:
    name: Luxury Tax
    action: luxury_tax
39:
    name: Boardwalk
    rent: [50, 200, 600, 1400, 1700, 2000]
    land_price: 400
    house_price: 200
    group: street8
ENDOFBOARD

