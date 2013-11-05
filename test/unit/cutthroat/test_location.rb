require 'test/unit'
require 'cutthroat'

class TestLocation < Test::Unit::TestCase

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
  
  def test_location_lookup
    l1 = Cutthroat::Location.lookup(0)
    l2 = Cutthroat::Location.lookup(0)
    assert_equal(l1, l2)
  end

  def test_location_id
    location = Cutthroat::Location.lookup(4)
    assert_equal(4, location.id)
  end

end
