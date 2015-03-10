
module Cutthroat

  class CutthroatError < StandardError
  end

  class PropertyError < CutthroatError
  end

  class MortgageError < PropertyError
  end

  class AlreadyMortgaged < MortgageError
  end

  class NotOwner < MortgageError
  end

  class NotMortgaged < MortgageError
  end

  class BuildingError < MortgageError
  end

  class NotOwnerOfAllInGroup < PropertyError
  end

  class NoBuilding < PropertyError
  end

  class DistributionError < PropertyError
  end

  class OutOfStockError < PropertyError
  end

end
