
module Cutthroat
  class Player

    attr_reader :location
    attr_reader :name
    attr_reader :turns_played
    attr_reader :balance

    attr_accessor :game

    def initialize(name = "anonymous player")
      @location = nil
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
      move_to(game.find_location((sum + location.to_i) % LOCATIONS))
      location.trigger_action(self)
      if (location.to_i == 30)
        move_to(game.find_location(10))
      else
        if player_touched_go(sum)
          receive(SALARY)
        end
        if location.to_i == 4
          ten_percent = total_worth / 10
          charge(ten_percent < 200 ? ten_percent : 200 )
        end
      end
      @turns_played += 1
    end

    def player_touched_go(eyes_rolled)
      (location.to_i - eyes_rolled) < 0
    end

    def total_worth
      # currently only balance is taken into account
      @balance
    end

  end
end
