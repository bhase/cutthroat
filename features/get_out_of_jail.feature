Feature: Get out of Jail
  As a player, when I am in Jail at the beginning of my turn I can
  pay $50 to take a normal turn.

  @draft
  Scenario: Pay $50
    Given a player in Jail
    When the player pays $50
    Then the balance of this player is decreased by $50
    And the player is no longer in Jail and rolls dice to move

  @draft
  Scenario: Pay $50, roll double
    Given a player in Jail pays $50 to get out
    When the player rolls double
    Then the player moves and rolls again
