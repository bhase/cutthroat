
module KnowsPlayer
  def player
    @player ||= Cutthroat::Player.new()
  end

  def play_turn_from(location)
    player.move_to(location)
    player.play_turn(dice)
  end

  def set_worth_of_player_to(amount)
    delta = amount - player.total_worth
    player.receive(delta)
  end

  def play_turn_and_land_on(location)
    dice.should_receive(:roll).and_return([1,2])
    play_turn_from(board.lookup((location.to_i - 3) % Cutthroat::LOCATIONS))
  end

  def play_turn_and_pass_over(location)
    dice.should_receive(:roll).and_return([1,2])
    play_turn_from(board.lookup((location.to_i - 2) % Cutthroat::LOCATIONS))
  end

end

module KnowsGame
  def game
    @game ||= Cutthroat::Game.new()
  end

  def initial_players
    @initial_players ||= Hash.new(0)
  end

  def player_list_at_round
    @player_list_at_round ||= []
  end

  def start_a_game
    game.add_player(player)
    game.add_player(Cutthroat::Player.new("p2"))
    game.start
  end

  def dice
    @dice ||= double()
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

end

World(KnowsPlayer)
World(KnowsGame)
