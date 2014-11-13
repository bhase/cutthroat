Feature: Get out of Jail
  As a player, when I am in Jail at the beginning of my turn I can
  - pay a fee to take a normal turn
  - try to roll a double
  - play a get out of Jail card
  to get out of Jail

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

  Scenario: Roll dice, no double
    Given a player in Jail
    When the player rolls dice to leave jail and does not roll double
    Then the player is still in Jail and does not move

  Scenario: Roll dice, double
    Given a player in Jail
    When the player rolls dice to leave Jail and rolls double
    Then the player is no longer in Jail and moves on

  Scenario: Roll dice, no double for three times
    Given a player in Jail
    When the player rolls dice and does not roll double for three turns
    Then the player has to pay the Jail fee
    And moves with the eyes of the last throw
