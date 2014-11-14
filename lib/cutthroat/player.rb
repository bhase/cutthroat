
module Cutthroat
  class Player

    attr_reader :location
    attr_reader :name
    attr_accessor :turns_played
    attr_reader :balance
    attr_accessor :last_throw
    attr_accessor :in_jail
    attr_accessor :in_jail_since
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

    def touched_go
      (@previous_location.to_i > @location.to_i)
    end

    def total_worth
      # TODO currently only balance is taken into account
      # total worth consists of
      # - printed prices of owned properties
      # - buy prices of houses and hotels
      # - cash
      locations = @game.find_locations_owned_by(self)
      @balance + locations.inject(0){|sum, l| sum + l.land_price }
    end

    # TODO worth
    # this will be used to calculate bankruptcy
    # difference to total_woth:
    # - houses and hotels get half price
    # - properties get mortgage value if not mortgaged

    def mortgage(location)
      location.mortgage(self)
    end

    def arrest_at(location)
      move_to(location)
      @in_jail = true
      @in_jail_since = @turns_played
    end

    def register_callouts(user_callouts)
      @callout = user_callouts
      self
    end

    def method_missing(sym, *args)
      if @callout.respond_to?(sym)
        @callout.send(sym, args)
      else
        super
      end
    end

  end
end
