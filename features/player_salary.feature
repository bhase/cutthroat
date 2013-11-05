Feature: Player gets salary when landing on or passing Go

  @draft
  Scenario: Landing on Go
    Given a player
    When the player lands on 'Go'
    Then the balance of this player is increased by $200

  @draft
  Scenario: Passing Go
    Given a player
    When the player passes 'Go'
    Then the balance of this player is increased by $200

  @draft
  Scenario: Leaving Go
    Given a player on 'Go'
    When the player leaves Go
    Then the balance of this player is unchanged

  @draft
  Scenario: Normal move
    Given a player
    When the player moves without touching 'Go'
    Then the balance of this player is unchanged

  @draft
  Scenario: Pass Go twice
    Given a player
    When the player passes 'Go' twice during his turn
    Then the balance of this player is increased by $400
