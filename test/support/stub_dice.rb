
class StubDices

  attr_accessor :roll_called
  attr_accessor :sequence

  def initialize
    @roll_called = 0
    @sequence = []
  end

  def roll
    @roll_called += 1
    @sequence.shift
  end

end
