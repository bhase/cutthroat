Feature: Go To Jail
  As a player, when I land on Go To Jail during a turn
  I move directly to Just Visiting.

  @draft
  Scenario: Landing on Go To Jail
    Given a player before 'Go To Jail'
    When the player lands on 'Go To Jail'
    Then the player shall end on 'Just Visiting'
    And the balance of this player is unchanged

  @wip
  Scenario: Passing Go To Jail
    Given a player on 'B&O RR'
    When the player rolls enough to land on 'Short Line'
    Then the player shall end on 'Short Line'
    And the balance of this player is unchanged
