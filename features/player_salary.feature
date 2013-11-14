Feature: Player gets salary when landing on or passing Go
  During a game when a player lands on Go or passes Go he or she shall
  receive his/her salary ($200). It is possible to pass Go twice
  during a turn, then for each pass the salary is received.

  Scenario: Landing on Go
    Given a player in a game
    When the player lands on 'Go'
    Then the balance of this player is increased by $200

  Scenario: Passing Go
    Given a player in a game
    When the player passes 'Go'
    Then the balance of this player is increased by $200

  Scenario: Leaving Go
    Given a player on 'Go'
    When the player leaves Go
    Then the balance of this player is unchanged

  Scenario: Normal move
    Given a player in a game
    When the player moves without touching 'Go'
    Then the balance of this player is unchanged

  @draft
  Scenario: Pass Go twice
    Given a player
    When the player passes 'Go' twice during his turn
    Then the balance of this player is increased by $400
