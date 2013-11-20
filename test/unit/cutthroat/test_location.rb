require 'test/unit'
require 'cutthroat'

class TestLocation < Test::Unit::TestCase

  GO = <<EOG
---
!ruby/object:Cutthroat::Location
    position: 0
    name: Go
    type: !ruby/sym action
EOG
  MEDITERRANEAN_AVE = <<EOA
---
!ruby/object:Cutthroat::Location
    position: 1
    name: Mediterranean Avenue
    type: !ruby/sym property
EOA

  def setup
    @go = YAML.parse(GO).to_ruby
    @avenue = YAML.parse(MEDITERRANEAN_AVE).to_ruby
  end

  def test_location_type_action
    assert_equal(:action, @go.type)
  end

  def test_location_type_property
    assert_equal(:property, @avenue.type)
  end

  def test_location_name
    assert_equal("Go", @go.name)
    assert_equal("Mediterranean Avenue", @avenue.name)
  end
end
