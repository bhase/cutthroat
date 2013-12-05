
module Cutthroat

  class CutthroatError < StandardError
  end

  class TooFewPlayerError < CutthroatError
  end

  class TooManyPlayerError < CutthroatError
  end

  class PlayerExistsError < CutthroatError
  end

  class Game

    attr_reader :players
    attr_reader :active
    attr_reader :board

    def initialize(dice = Cutthroat::Dice.new)
      @players = []
      @active = false
      @dice = dice
      @board = Cutthroat::Board.new
    end

    def add_player(player)
      raise TooManyPlayerError, "too many player, maximum is eight" if
        @players.length >= 8
      raise PlayerExistsError, "a player named #{player.name} already exists" if
        @players.any?{|p| p.name == player.name }
      player.game = self
      @players << player
    end

    def start
      raise TooFewPlayerError, "too few player: need at least two" unless @players.length > 1
      players.shuffle!
      players.each { |p| p.move_to(board.lookup(0)) }
      @active = true
    end

    def play_round
      players.each {|p| p.play_turn(@dice) }
    end

    def cancel
      @active = false
    end

    def find_location(l)
      board.lookup(l)
    end

    def find_locations_owned_by(player)
      board.all_owned_by(player)
    end

  end
end
