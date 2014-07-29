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

    attr_reader :owner
    attr_reader :is_mortgaged

    attr_accessor :board

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

      if owner.nil?
        if player.buy_property?(self)
          record_rights(player)
        end
      elsif (owner != player && is_mortgaged != true)
        rent = calculate_rent(player)
        player.charge(rent)
        owner.receive(rent)
      end
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
      player.charge(land_price * (MORTGAGE_RATE + MORTGAGE_DUTY) / 100)
      @is_mortgaged = false
    end

    private

    def calculate_rent(player)
      properties_in_group = board.all_of_group(group)
      properties_owned_in_group =  board.all_owned_by(self.owner) & properties_in_group
      case group
      when :utility
        rent_for_utility(player.last_throw.inject(:+), properties_in_group)
      when :railroad
        rent_for_railroad(properties_owned_in_group)
      else
        rent_for_property(properties_owned_in_group, properties_in_group)
      end
    end

    def put_in_jail(player)
      player.arrest_at(board.find_jail)
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
      location = board.find_go
      player.move_to(location)
      location.trigger_action(player)
    end

    def record_rights(player)
      player.charge(land_price)
      @owner = player
    end

    def rent_for_utility(eyes, properties_in_group)
        if properties_in_group.none? { |p| p.owner.nil? }
          eyes * 10
        else
          eyes * 4
        end
    end

    def rent_for_railroad(properties_owned_in_group)
        rent * (2 ** (properties_owned_in_group.length - 1))
    end

    def rent_for_property(properties_owned_in_group, properties_in_group)
        if properties_owned_in_group == properties_in_group
          rent * 2
        else
          rent
        end
    end

  end
end
