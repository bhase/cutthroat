require "cutthroat/error"

module Cutthroat

  ##
  # This exception is reported when someone tries to start a game but there
  # are not enough player registered at the moment.
  #
  class TooFewPlayerError < CutthroatError
  end

  ##
  # This exception is reported when someone tries to register another player
  # while the maximum number of player is reached.
  #
  class TooManyPlayerError < CutthroatError
  end


  ##
  # This exception is reported when someone tries to register a player while
  # another player with the same name already exists in this game.
  #
  class PlayerExistsError < CutthroatError
  end

  ##
  # = The Game class.
  #
  # Handles game logic and player management.
  #
  class Game

    attr_reader :players
    attr_reader :active
    attr_reader :board
    attr_reader :dice

    attr_reader :remaining_houses
    attr_reader :remaining_hotels

    def initialize(dice = Cutthroat::Dice.new)
      @players = []
      @active = false
      @dice = dice
      @board = Cutthroat::Board.new
      @remaining_houses = 32
      @remaining_hotels = 12
    end

    def add_player(player)
      raise TooManyPlayerError, "too many player, maximum is eight" if
        @players.length >= 8
      raise PlayerExistsError, "a player named #{player.name} already exists" if
        @players.any?{|p| p.name == player.name }
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
        pre_hook(p)
        if p.in_jail == true
          jail_turn(p)
        else
          play_turn(p)
        end
        post_hook(p)
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
        player.last_throw = dice.roll
        double_count += 1 if player.last_throw[0] == player.last_throw[1]
        break if double_count >= 3
        player.move
        break if player.last_throw[0] != player.last_throw[1]
      end
      if (double_count >= 3)
        player.arrest_at(board.find_jail)
      end
    end

    def jail_turn(player)
      player.last_throw = dice.roll
      if (player.last_throw[0] == player.last_throw[1])
        player.in_jail = false
        player.move
      elsif third_turn_in_jail(player)
        player.charge(Cutthroat::JAIL_FEE)
        player.in_jail = false
        player.move
      end
    end

    def third_turn_in_jail(player)
      (player.turns_played - player.in_jail_since) >= 2
    end

    # Actions that can be done in pre_hook
    # - buy house, hotel
    # - sell house, hotol, property
    # - mortgage, un-mortgae
    # - trade
    # - leave jail with payment or card
    # - roll dice (ends pre_hook)
    def pre_hook(player)
      loop do
        action, *args = player.pre_hook
        case action
        when :roll_dice
          break
        when :pay_jail_fee
          player.charge(Cutthroat::JAIL_FEE)
          player.in_jail = false
        when :buy_house
          raise OutOfStockError, "no house in stock left" if @remaining_houses < 1
          args[0].buy_building(player)
        when :buy_hotel
          raise OutOfStockError, "no hotel in stock left" if @remaining_hotels < 1
          args[0].buy_building(player)
        when :sell_house, :sell_hotel
          args[0].sell_building(player)
        when :mortgage
          args[0].mortgage(player)
        when :cancel_mortgage
          args[0].cancel_mortgage(player)
        end
      end
    end

    # Actions that can be done in post_hook
    # - buy house, hotel
    # - sell house, hotel, property
    # - mortgage, un-mortgage
    # - trade
    # - end turn
    def post_hook(player)
      player.turns_played += 1
    end
  end
end
