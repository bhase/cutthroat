Feature: Income Tax
  As a player when I land on Income Tax I need to pay the smaller of
  10% of my total worth or $200.

  Scenario Outline: Landing on Income Tax
    Given a player with a total worth of <Worth>
    When the player lands on 'Income Tax'
    Then the balance of this player is decreased by <Tax>

    Examples:
      | Worth  | Tax  |
      | $1800  | $180 |
      | $2200  | $200 |
      |    $0  |   $0 |
      | $2000  | $200 |

  Scenario: Passing over Income Tax
    Given a player in a game
    When the player passes over 'Income Tax'
    Then the balance of this player is unchanged
