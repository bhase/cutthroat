Feature: Buy Property
  As a player, I can buy unowned property when I land on it during a turn.

  Background:
    Given a player in a game

  Scenario: Buying unowned property
    Given 'Virginia Avenue' is unowned
    When the player lands on 'Virginia Avenue' and decides to buy
    Then the balance of this player is decreased by cost of property
    And the player owns 'Virginia Avenue'

  Scenario: Landing on self owned property
    Given a player owns 'Pennsylvania Avenue'
    When the player lands on 'Pennsylvania Avenue'
    Then the balance of this player is unchanged

  Scenario: Passing unowned property
    Given 'B&O RR' is unowned
    When the player passes over 'B&O RR'
    Then the balance of this player is unchanged
    And 'B&O RR' is still unowned
