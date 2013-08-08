
require 'test/unit'
require 'cutthroat/player'

class TestPlayer < Test::Unit::TestCase
  def test_new_player
    player = Cutthroat::Player.new("dummy")
    refute_nil(player)
  end
end
