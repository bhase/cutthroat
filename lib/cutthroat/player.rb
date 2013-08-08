
module Cutthroat
  class Player

    attr_reader :location

    def initialize()
      @location = 0
    end

    def move_to(location)
      @location = location
    end
  end
end
