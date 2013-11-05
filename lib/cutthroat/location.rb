
module Cutthroat
  class Location
    attr_reader :id

    @@locations = []

    def self.lookup(number)
      @@locations[number] ||= Location.new(number)
    end

    def initialize(number)
      @id = number
    end

  end
end
