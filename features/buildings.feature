Feature: Buildings
  As a player I can improve my properties with buildings to receive more rent.
  Also I can sell buildings to receive some cash.
  Buildings must be evenly distributed in one group.

  @draft
  Scenario: Buy House
    Given a player owns 'Kentucky Avenue'
    When the player decides to buy a house for 'Kentucky Avenue'
    Then the player is charged by the price of a house on 'Kentucky Avenue'
    And on 'Kentucky Avenue' stands one house

  @draft
  Scenario: Sell House
    Given a player owns one house on 'New York Avenue'
    When the player decides to sell a house from 'New York Avenue'
    Then the player receives half of the price of a house on 'New York Avenue'
    And on 'New York Avenue' stands no house

  @draft
  Scenario: Buy Hotel
    Given a player owns four houses on 'Vermont Avenue'
    When the player decides to buy a hotel for 'Vermont Avenue'
    Then the player is charged by the price of a house on 'Vermont Avenue'
    And on 'Vermont Avenue' stands one hotel

  @draft
  Scenario: Sell Hotel
    Given a player owns one hotel on 'Baltic Avenue'
    When the player decides to sell the hotel from 'Baltic Avenue'
    Then the player receives half of the price of a house on 'Baltic Avenue'
    And on 'Baltic Avenue' stand four houses

  @draft
  Scenario: Buy House, Not All Streets in Group Owned
    Given a player owns 'Baltic Avenue'
    But 'Mediterranean Avenue' is unowned
    When the player decides to buy a house for 'Baltic Avenue'
    Then he should receive a message 'must own all properties in group'

  @draft
  Scenario: Buy House, Unowned Property
    Given 'Baltic Avenue' is unowned
    When the player decides to buy a house for 'Baltic Avenue'
    Then he should receive a message 'not your property'

  @draft
  Scenario: Distribute Evenly
    Given a player owns the following set of houses:
      | Street            | Houses |
      | 'Atlantic Avenue' |    1   |
      | 'Ventnor Avenue'  |    2   |
      | 'Marvin Gardens'  |    1   |
    When the player decides to buy a house for 'Ventnor Avenue'
    Then he should receive a message 'distribute evenly'

  @draft
  Scenario: Sell Hotel, not enough houses
    Given a player owns a hotel on 'Tennessee Avenue'
    And the bank has only two houses left
    When the player decides to sell the hotel from 'Tennessee Avenue'
    Then he should receive a message 'not possible'
    And on 'Tennessee Avenue' stands one hotel
