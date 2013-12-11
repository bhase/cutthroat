require 'test/unit'
require 'cutthroat'

class TestLocation < Test::Unit::TestCase

  GO = <<EOG
---
!ruby/object:Cutthroat::Location
    position: 0
    name: Go
EOG
  MEDITERRANEAN_AVE = <<EOA
---
!ruby/object:Cutthroat::Location
    position: 1
    name: Mediterranean Avenue
EOA

  def setup
    @go = YAML.parse(GO).to_ruby
    @avenue = YAML.parse(MEDITERRANEAN_AVE).to_ruby
  end

  def test_location_name
    assert_equal("Go", @go.name)
    assert_equal("Mediterranean Avenue", @avenue.name)
  end

  def test_location_to_string
    assert_match(/^Mediterranean Avenue$/, @avenue.to_s)
  end

  def test_location_to_number
    assert_equal(1, @avenue.to_i)
  end

  def test_location_responds_to_trigger_action
    assert(@go.respond_to?(:trigger_action) == true,
           "location does not respond to trigger_action")
  end

end
