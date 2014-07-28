require "cutthroat/error"

module Cutthroat

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
    attr_reader :dice

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
      players.each { |p| p.move_to(board.find_go) }
      @active = true
    end

    def play_round
      players.each {|p|
        if p.in_jail == true
          p.leave_jail_with?
        else
          play_turn(p)
        end
      }
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

    def find_locations_of_group(group)
      board.all_of_group(group)
    end

    def play_turn(player)
      double_count = 0
      loop do
        # user callout here - user can take action or not
        player.last_throw = dice.roll
        double_count += 1 if player.last_throw[0] == player.last_throw[1]
        break if double_count >= 3
        sum = player.last_throw.reduce(:+)
        player.move_to(find_location((sum + player.location.to_i) % board.locations))
        player.location.trigger_action(player)
        break if player.last_throw[0] != player.last_throw[1]
      end
      # and user callout here
      player.turns_played += 1
      if (double_count >= 3)
        player.arrest_at(board.find_jail)
      end
    end

  end
end
