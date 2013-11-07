module Cutthroat
  class Board

    def initialize
      @locations = []
    end

    def lookup(number)
      @locations[number] ||= Location.new(number)
    end

  end
end
