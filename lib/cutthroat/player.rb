
module Cutthroat
  class Player

    attr_reader :location

    def initialize()
      @location = 0
    end

    def move_to(location)
      @location = location
    end

    def play_turn(dices)
      sum = dices.roll + dices.roll
      move_to(sum + @location)
    end
  end
end
