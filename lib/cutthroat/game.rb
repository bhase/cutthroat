
module Cutthroat

  class CutthroatError < StandardError
  end

  class TooFewPlayerError < CutthroatError
  end

  class TooManyPlayerError < CutthroatError
  end

  class Game

    attr_reader :players
    attr_reader :active

    def initialize
      @players = []
      @active = false
    end

    def add_player(player)
      raise TooManyPlayerError, "too many player, maximum is eight" unless @players.length < 8
      @players << player
    end

    def start
      raise TooFewPlayerError, "too few player: need at least two" unless @players.length > 1
      players.shuffle!
      @active = true
    end

  end
end
