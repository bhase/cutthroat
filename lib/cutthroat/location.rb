
module Cutthroat
  class Location
    attr_reader :position
    attr_reader :name
    attr_reader :type
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
          player.charge(75)
        end

        if (owner != nil && owner != player)
          player.charge(rent)
          owner.receive(rent)
        end
      end
    end

    def record_rights(player)
      player.charge(land_price)
      self.owner = player
    end

  end
end
