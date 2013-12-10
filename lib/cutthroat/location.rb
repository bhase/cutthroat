
module Cutthroat
  class Location
    attr_reader :position
    attr_reader :name
    attr_reader :type
    attr_reader :group
    attr_reader :land_price
    attr_reader :rent

    attr_accessor :owner

    def to_s
      @name
    end

    def to_i
      @position
    end

    def trigger_action(player)
      if (position == 30)
        player.move_to(player.game.find_location(10))
      else
        if player.touched_go
          player.receive(SALARY)
        end
        if position == 4
          ten_percent = player.total_worth / 10
          player.charge(ten_percent < 200 ? ten_percent : 200 )
        end
        if position == 38
          player.charge(LUXURY_TAX)
        end

        if (owner != nil && owner != player)
          rent = calculate_rent(player)
          player.charge(rent)
          owner.receive(rent)
        end
      end
    end

    def record_rights(player)
      player.charge(land_price)
      self.owner = player
    end

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

  end
end
