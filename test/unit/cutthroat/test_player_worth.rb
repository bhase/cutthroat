require 'test/unit'
require 'cutthroat'

class TestPlayerWorth < Test::Unit::TestCase

  # For now, worth is only balance.
  # In future it should include also
  # - properties (land price, no matter if mortgaged)
  # - improvements (printed price to buy house/hotel)
  def setup
    @player = Cutthroat::Player.new()
    @game = Cutthroat::Game.new()
    @player.game = @game
  end

  def test_initial_worth
    assert_equal(@player.total_worth, Cutthroat::SEED_CAPITAL)
  end

  def test_player_receives
    @player.receive(200)
    assert_equal(Cutthroat::SEED_CAPITAL + 200, @player.total_worth)
  end

  def test_player_charged
    @player.charge(100)
    assert_equal(Cutthroat::SEED_CAPITAL - 100, @player.total_worth)
  end

  def test_player_owns_properties
    location = @game.find_location('Mediterranean Avenue')
    location.instance_variable_set('@owner', @player)
    assert_equal(Cutthroat::SEED_CAPITAL + location.land_price, @player.total_worth)
  end

  def test_player_owns_building
    location = @game.find_location('Mediterranean Avenue')
    location.instance_variable_set('@owner', @player)
    location.instance_variable_set('@buildings', 3)
    assert_equal(Cutthroat::SEED_CAPITAL + location.land_price + 3 * location.house_price, @player.total_worth)
  end

end
