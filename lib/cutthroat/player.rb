
module Cutthroat
  class Player

    attr_reader :location
    attr_reader :name
    attr_reader :turns_played
    attr_reader :balance

    def initialize(name = "anonymous player")
      @location = 0
      @name = name
      @turns_played = 0
      @balance = SEED_CAPITAL
    end

    def move_to(location)
      @location = location
    end

    def receive(amount)
      @balance += amount
    end

    def play_turn(dices)
      sum = dices.roll.reduce(:+)
      move_to((sum + @location) % LOCATIONS)
      @turns_played += 1
    end
  end
end
