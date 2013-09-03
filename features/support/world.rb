
module KnowsPlayer
  def player
    @player ||= Cutthroat::Player.new()
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
end

World(KnowsPlayer)
World(KnowsGame)

Test::Unit::AutoRunner.need_auto_run = false
