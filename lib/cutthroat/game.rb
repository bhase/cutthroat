
module Cutthroat
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
      @active = true
    end

  end
end
