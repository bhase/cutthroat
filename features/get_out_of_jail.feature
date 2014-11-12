Feature: Get out of Jail
  As a player, when I am in Jail at the beginning of my turn I can
  pay a fee to take a normal turn.

  Scenario: Pay Fee
    Given a player in Jail
    When the player pays the Jail fee at begin of his turn
    Then the balance of this player is decreased by the fee
    And the player is no longer in Jail and moves on

  @draft
  Scenario: Pay Fee, roll double
    Given a player in Jail
    When the player pays the Jail fee at begin of his turn
    And the player rolls double
    Then the player moves and rolls again
