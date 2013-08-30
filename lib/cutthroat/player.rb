
module Cutthroat
  class Player

    attr_reader :location
    attr_reader :name
    attr_reader :turns_played

    def initialize(name = "anonymous player")
      @location = 0
      @name = name
      @turns_played = 1
    end

    def move_to(location)
      @location = location
    end

    def play_turn(dices)
      sum = dices.roll + dices.roll
      move_to((sum + @location) % 40)
    end
  end
end
