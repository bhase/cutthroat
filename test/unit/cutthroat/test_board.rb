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
  
  def test_lookup_singularity
    l1 = @board.lookup(0)
    l2 = @board.lookup(0)
    assert_equal(l1, l2)
  end

  def test_lookup_by_name
    location = @board.lookup('Go')
    assert_equal(0, location.position)
  end

  def test_lookup_by_position
    location = @board.lookup(4)
    assert_equal(4, location.position)
  end

  def test_find_jail
    location = @board.find_jail
    assert_equal(10, location.position)
  end

  def test_find_go
    location = @board.find_go
    assert_equal(0, location.position)
  end

  def test_locations
    # built-in default board has 40 locations
    assert_equal(40, @board.locations)
  end
end
