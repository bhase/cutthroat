require 'test/unit'
require 'cutthroat'

class TestBoard < Test::Unit::TestCase

  # location.name
  # location.id => Field number
  # Cutthroat::Location.lookup(id) # => location
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
  
  def test_location_lookup
    l1 = @board.lookup(0)
    l2 = @board.lookup(0)
    assert_equal(l1, l2)
  end

  def test_location_id
    location = @board.lookup(4)
    assert_equal(4, location.id)
  end

end
