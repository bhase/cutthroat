Feature: Chance Card
  As a player, when I land on Chance I need to pull a card from the stack
  and perform the described action.

  Background: a player on 'Baltic Avenue'

  @draft
  Scenario: Advance to Go
    When the player pulls the card "Advance to Go"
    Then the player shall end on 'Go'
    And the balance of this player is increased by $200

  @draft
  Scenario: Chairman of the Board
    Given a game with three players
    When the player pulls the card "You have elected Chairman of the Board"
    Then the balance of this player is decreased by $150
    And the balance of each other player is increased by $50
