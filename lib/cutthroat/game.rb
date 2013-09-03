
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

    def initialize(dices = Cutthroat::Dices.new)
      @players = []
      @active = false
      @dices = dices
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

    def play_round
      players.each {|p| p.play_turn(@dices) }
    end

    def cancel
      @active = false
    end

  end
end
