Feature: Luxury Tax
  As a player, when I land on Luxury Tax, I pay $75.

  Scenario: Landing on Luxury Tax
    Given a player in a game
    When the player lands on 'Luxury Tax'
    Then the balance of this player is decreased by $75

  @draft
  Scenario: Passing Luxury Tax
    Given a player in a game
    When the player passes 'Luxury Tax'
    Then the balance of this player is unchanged
