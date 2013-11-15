require 'test/unit'
require 'cutthroat'

class TestBoard < Test::Unit::TestCase

  # location.name
  # location.id => Field number
  # board.lookup(id) # => location
  # 
  # Further properties to come
  # price
  # rent
  # group
  # owner
  # action to trigger
  #

  def setup
    @board = Cutthroat::Board.new
  end
  
  def test_location_lookup_singularity
    l1 = @board.lookup(0)
    l2 = @board.lookup(0)
    assert_equal(l1, l2)
  end

  def test_location_lookup_by_name
    l1 = @board.lookup('Go')
    assert_equal(0, l1.position)
  end

  def test_location_position
    location = @board.lookup(4)
    assert_equal(4, location.position)
  end

  def test_location_type_action
    go = @board.lookup(0)
    assert_equal(:action, go.type)
  end

  def test_location_type_property
    avenue = @board.lookup(1)
    assert_equal(:property, avenue.type)
  end

  def test_location_name
    assert_equal("Go", @board.lookup(0).name)
    assert_equal("Mediterranean Avenue", @board.lookup(1).name)
  end

end
