Feature: Roll Double
  As a player, when I roll double, my turn continues
  and I land on new locations.

  Scenario: Roll Double
    Given a player on 'Go'
    When the player rolls the following sequence
      | [3, 3] |
      | [1, 3] |
    Then the player shall end on 'Just Visiting'

  Scenario: Roll Double Twice
    Given a player on 'Go'
    When the player rolls the following sequence
      | [6, 6] |
      | [6, 6] |
      | [3, 4] |
    Then the player shall end on 'Pacific Avenue'

  @draft
  Scenario: Roll Double thrice
    Given a player on 'Go'
    When the player rolls the following sequence
      | [4, 4] |
      | [3, 3] |
      | [1, 1] |
    Then the player shall end in jail

