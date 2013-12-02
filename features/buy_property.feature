Feature: Buy Property
  As a player, I can buy unowned property when I land on it during a turn.

  @draft
  Scenario: Buying unowned property
    Given 'B&O RR' is unowned
    And the player lands on 'B&O RR'
    When the player decides to buy this property
    Then the balance of this player is decreased by cost of property
    And the player owns 'B&O RR'

  @draft
  Scenario: Landing on self owned property
    Given 'B&O RR' is owned by player
    When the player lands on 'B&O RR'
    Then the balance of this player is unchanged

  @draft
  Scenario: Passing unowned property
    Given 'B&O RR' is unowned
    When the player passes over 'B&O RR'
    Then the balance of this player is unchanged
    And 'B&O RR' is still unowned
