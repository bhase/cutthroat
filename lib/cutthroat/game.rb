
module Cutthroat
  class TooFewPlayerError < StandardError
  end

  class Game

    attr_reader :players
    attr_reader :active

    def initialize
      @players = []
      @active = false
    end

    def add_player(player)
      @players << player
    end

    def start
      raise TooFewPlayerError, "too few player: need at least two" unless @players.length > 1
      @active = true
    end

  end
end
