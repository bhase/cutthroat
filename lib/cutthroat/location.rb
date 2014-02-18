require "cutthroat/error"

module Cutthroat

  class MortgageError < CutthroatError
  end

  class AlreadyMortgaged < MortgageError
  end

  class NotOwner < MortgageError
  end

  class NotMortgaged < MortgageError
  end

  class Location
    attr_reader :position
    attr_reader :name
    attr_reader :type
    attr_reader :group
    attr_reader :land_price
    attr_reader :rent

    attr_accessor :owner
    attr_reader :is_mortgaged

    def to_s
      @name
    end

    def to_i
      @position
    end

    def trigger_action(player)
      if !@action.nil?
        send @action, player
      end

      if player.touched_go and not player.in_jail
        player.receive(SALARY)
      end

      if (owner != nil && owner != player)
        rent = calculate_rent(player)
        player.charge(rent)
        owner.receive(rent)
      end
    end

    def record_rights(player)
      player.charge(land_price)
      self.owner = player
    end

    def mortgage(player)
      raise AlreadyMortgaged, "#{self} is already mortgaged" if @is_mortgaged == true
      raise NotOwner, "#{self} is not your property" if @owner != player
      player.receive(land_price * MORTGAGE_RATE / 100)
      @is_mortgaged = true
    end

    def cancel_mortgage(player)
      raise NotOwner, "#{self} is not your property" if @owner != player
      raise NotMortgaged, "#{self} is not mortgaged" if @is_mortgaged != true
      player.charge(land_price)
      @is_mortgaged = false
    end

    private

    def calculate_rent(player)
      game = player.game
      properties_in_group = game.find_locations_of_group(group)
      if (group == :utility)
        eyes = player.last_throw.inject(:+)
        if properties_in_group.none?{|p| p.owner.nil?}
          eyes * 10
        else
          eyes * 4
        end
      else
        properties_owned = game.find_locations_owned_by(self.owner)
        properties_owned_in_group = properties_owned & properties_in_group
        if (group == :railroad)
          rent * (2 ** (properties_owned_in_group.length - 1))
        else
          if properties_owned_in_group == properties_in_group
            rent * 2
          else
            rent
          end
        end
      end
    end

    def put_in_jail(player)
      player.arrest_at(player.game.find_location(10))
    end

    def income_tax(player)
      ten_percent = player.total_worth / 10
      player.charge(ten_percent < MAX_INCOME_TAX ? ten_percent : MAX_INCOME_TAX)
    end

    def luxury_tax(player)
      player.charge(LUXURY_TAX)
    end

    def chance(player)
      # TODO implement chance cards
      location = player.game.board.find_go
      player.move_to(location)
      location.trigger_action(player)
    end

  end
end
