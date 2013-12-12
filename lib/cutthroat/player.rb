
module Cutthroat
  class Player

    attr_reader :location
    attr_reader :name
    attr_reader :turns_played
    attr_reader :balance
    attr_reader :last_throw

    attr_accessor :game

    def initialize(name = "anonymous player")
      @location = nil
      @previous_location = @location
      @name = name
      @turns_played = 0
      @balance = SEED_CAPITAL
    end

    def move_to(location)
      @previous_location = @location
      @location = location
    end

    def receive(amount)
      @balance += amount
    end

    def charge(amount)
      @balance -= amount
    end

    def play_turn(dice)
      loop do
        @last_throw = dice.roll
        sum = last_throw.reduce(:+)
        move_to(game.find_location((sum + location.to_i) % LOCATIONS))
        location.trigger_action(self)
        break if @last_throw[0] != @last_throw[1]
      end
      @turns_played += 1
    end

    def touched_go
      (@previous_location.to_i > @location.to_i)
    end

    def total_worth
      # currently only balance is taken into account
      @balance
    end

  end
end
