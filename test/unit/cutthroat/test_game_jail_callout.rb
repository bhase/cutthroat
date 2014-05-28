require 'test/unit'
require 'cutthroat/game'
require 'cutthroat'

class TestGameJailCallout < Test::Unit::TestCase

  def setup
    @game = Cutthroat::Game.new()
    @game.add_player(Cutthroat::Player.new)
    @game.players[0].arrest_at(@game.board.find_jail)
    @user_callouts = mock
    @game.players[0].register_callouts(@user_callouts)
  end

  def test_game_asks_arrested_player
    @user_callouts.expects(:leave_jail_with?)
    @game.play_round
  end

end
