Feature: Roll Double
  As a player, when I roll double, my turn continues
  and I land on new locations.

  Scenario: Roll Double
    Given a player on 'Go'
    When the player rolls the following sequence
      | Eyes rolled | Turn played? |
      | [3, 3]      | yes          |
      | [1, 3]      | yes          |
    Then the player shall end on 'Just Visiting'

  Scenario: Roll Double Twice
    Given a player on 'Go'
    When the player rolls the following sequence
      | Eyes rolled | Turn played? |
      | [6, 6]      | yes          |
      | [6, 6]      | yes          |
      | [3, 4]      | yes          |
    Then the player shall end on 'Pacific Avenue'

  Scenario: Roll Double Thrice - Go To Jail
    Given a player on 'Go'
    When the player rolls the following sequence
      | Eyes rolled | Turn played? |
      | [4, 4]      | yes          |
      | [3, 3]      | yes          |
      | [1, 1]      | no           |
    Then the player shall end in jail

