Feature: Buildings
  As a player I can improve my properties with buildings to receive more rent.
  Also I can sell buildings to receive some cash.
  Buildings must be evenly distributed in one group.

  Background:
    Given a player added to a game

  Scenario: Buy House
    Given a player owns 'Kentucky Avenue'
    And he owns all other properties in the group of 'Kentucky Avenue'
    When the player decides to buy a house for 'Kentucky Avenue'
    Then the player is charged by the price of a house on 'Kentucky Avenue'
    And on 'Kentucky Avenue' stands one house

  Scenario: Sell House
    Given a player owns one house on 'New York Avenue'
    When the player decides to sell a house from 'New York Avenue'
    Then the player receives half of the price of a house on 'New York Avenue'
    And on 'New York Avenue' stands no house

  Scenario: Buy Hotel
    Given a player owns four houses on 'Vermont Avenue'
    And he owns all other properties in the group of 'Vermont Avenue'
    When the player decides to buy a hotel for 'Vermont Avenue'
    Then the player is charged by the price of a house on 'Vermont Avenue'
    And on 'Vermont Avenue' stands one hotel

  Scenario: Sell Hotel
    Given a player owns one hotel on 'Baltic Avenue'
    When the player decides to sell the hotel from 'Baltic Avenue'
    Then the player receives half of the price of a house on 'Baltic Avenue'
    And on 'Baltic Avenue' stand four houses

  Scenario: Buy House, Not All Streets in Group Owned
    Given a player owns 'Baltic Avenue'
    But 'Mediterranean Avenue' is unowned
    When the player tries to buy a house for 'Baltic Avenue'
    Then he should receive a message 'must own all properties in group'
    And on 'Baltic Avenue' stands no house

  Scenario: Buy House, Unowned Property
    Given 'Baltic Avenue' is unowned
    When the player tries to buy a house for 'Baltic Avenue'
    Then he should receive a message 'not your property'
    And on 'Baltic Avenue' stands no house

  Scenario: Buy House, Foreign Property
    Given 'Kentucky Avenue' is owned by another player
    When the player tries to buy a house for 'Kentucky Avenue'
    Then he should receive a message 'not your property'

  @draft
  Scenario: Sell House, Unowned Property
    Given 'Tennessee Avenue' is unowned
    When the player tries to sell a house for 'Tennessee Avenue'
    Then he should receive a message 'not your property'

  @draft
  Scenario: Sell House, Foreign Property
    Given 'Kentucky Avenue' is owned by another player
    When the player tries to sell a house for 'Kentucky Avenue'
    Then he should receive a message 'not your property'

  @draft
  Scenario: Sell House, no house built
    Given a player owns 'New York Avenue'
    But on 'New York Avenue' stands no house
    When the player tries to sell a house from 'New York Avenue'
    Then he should receive a message 'no house to sell'

  @draft
  Scenario: Distribute Evenly
    Given a player owns the following set of houses:
      | Street            | Houses |
      | 'Atlantic Avenue' |    1   |
      | 'Ventnor Avenue'  |    2   |
      | 'Marvin Gardens'  |    1   |
    When the player tries to buy a house for 'Ventnor Avenue'
    Then he should receive a message 'distribute evenly'
    And on 'Ventnor Avenue' stand two houses

  @draft
  Scenario: Buy House, None Left
    Given a player owns 'Kentucky Avenue'
    And the bank has a remaining stock of zero houses
    When the player tries to buy a house for 'Kentucky Avenue'
    Then he should receive a message 'not possible'

  @draft
  Scenario: Sell Hotel, not enough houses
    Given a player owns a hotel on 'Tennessee Avenue'
    And the bank has a remaining stock of two houses
    When the player tries to sell the hotel from 'Tennessee Avenue'
    Then he should receive a message 'not possible'
    And on 'Tennessee Avenue' stands one hotel
    And the balance of the player is unchanged
