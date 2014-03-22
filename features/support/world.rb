
module KnowsPlayer
  def player
    @player ||= Cutthroat::Player.new()
  end

  def play_turn_from(location, p = player)
    p.move_to(location)
    p.play_turn(dice)
  end

  def set_worth_of_player_to(amount)
    delta = amount - player.total_worth
    player.receive(delta)
  end

  def play_turn_and_land_on(location, p = player)
    dice.should_receive(:roll).and_return([1,2])
    play_turn_from(board.lookup((location.to_i - 3) % board.locations), p)
  end

  def play_turn_and_pass_over(location)
    dice.should_receive(:roll).and_return([1,2])
    play_turn_from(board.lookup((location.to_i - 2) % board.locations))
  end

end

module KnowsGame

  class ::Cutthroat::Location
    def set_owner(player)
      @owner = player
    end
  end

  def last_error_message
    @message
  end

  def save_last_message(message)
    @message = message
  end

  def game
    @game ||= Cutthroat::Game.new(dice)
  end

  def balance_of
    @balance_of ||= {}
  end

  def initial_players
    @initial_players ||= Hash.new(0)
  end

  def player_list_at_round
    @player_list_at_round ||= []
  end

  def start_game_with_two_player
    game.add_player(player)
    game.add_player(Cutthroat::Player.new("p2"))
    game.start
  end

  def dice
    @dice ||= double(:roll => [2, 3])
  end

  def setup_dice_for(eyes)
    dice.should_receive(:roll).and_return([(eyes/2.0).floor, (eyes/2.0).ceil])
  end

  def add_game_player(*names)
    names.each do |name|
      game.add_player(Cutthroat::Player.new(name))
    end
  end

  def board
    game.board
  end

  def location
    @location ||= player.location
  end

  def find_player_by_name(name)
    game.players.find{ |p| p.name == name }
  end

  def fail_if_pos_reached(n)
    location = board.lookup n
    location.instance_variable_set(:@action, "explode")
    add_explode_method_to(location)
  end

  def add_explode_method_to(location)
    class << location
      def explode(player)
        fail "ERROR: #{player.name} should not have come here!"
      end
    end
  end
end

World(KnowsPlayer)
World(KnowsGame)
