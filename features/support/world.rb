
module KnowsPlayer
  def player
    @player ||= Cutthroat::Player.new()
  end

  def play_turn_from(location)
    player.move_to(location)
    player.play_turn(dice)
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
    @board ||= Cutthroat::Board.new
  end

end

World(KnowsPlayer)
World(KnowsGame)
