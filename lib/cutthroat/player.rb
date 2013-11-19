
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

    def charge(amount)
      @balance -= amount
    end

    def play_turn(dice)
      sum = dice.roll.reduce(:+)
      move_to((sum + @location) % LOCATIONS)
      if (location == 30)
        move_to(10)
      elsif player_touched_go(sum)
        receive(SALARY)
      end
      @turns_played += 1
    end

    def player_touched_go(eyes_rolled)
      (location - eyes_rolled) < 0
    end

  end
end
