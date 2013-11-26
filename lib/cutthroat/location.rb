
module Cutthroat
  class Location
    attr_reader :position
    attr_reader :name
    attr_reader :type

    def to_s
      @name
    end

    def to_i
      @position
    end

    def trigger_action
    end

  end
end
