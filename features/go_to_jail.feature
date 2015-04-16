Feature: Go To Jail
  As a player, when I land on Go To Jail during a turn
  I move directly to Just Visiting and I am in jail.

  Scenario: Landing on Go To Jail
    Given a player on 'New York Avenue'
    When the player rolls enough to land on 'Go To Jail'
    Then the player shall end on 'Just Visiting'
    And the balance of this player is unchanged
    And the player is in jail.

  Scenario: Passing Go To Jail
    Given a player on 'B&O Railroad'
    When the player rolls enough to land on 'North Carolina Avenue'
    Then the player shall end on 'North Carolina Avenue'
    And the balance of this player is unchanged
