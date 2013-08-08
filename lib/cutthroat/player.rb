
module Cutthroat
  class Player

    attr_reader :location

    def initialize(name)
    end

    def move_to(location)
      @location = location
    end
  end
end
