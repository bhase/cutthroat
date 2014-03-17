Feature: Pay rent
  As a player, I pay rent when I land on a property that is owned by another
  player - as long as the property is not mortgaged.

  Background:
    Given two player named "Albert" and "Fred" added to a game

  Scenario: Landing on Railroad when one is owned
    Given Albert owns 'B&O RR'
    When Fred lands on 'B&O RR'
    Then Fred pays $25 rent to Albert

  Scenario: Landing on Railroad when two are owned
    Given Albert owns 'B&O RR'
    And Albert owns 'Reading Railroad'
    When Fred lands on 'B&O RR'
    Then Fred pays $50 rent to Albert

  Scenario: Landing on Railroad when three are owned
    Given Albert owns these properties
      | B&O RR                |
      | Reading Railroad      |
      | Pennsylvania Railroad |
    When Fred lands on 'B&O RR'
    Then Fred pays $100 rent to Albert

  Scenario: Landing on Railroad when all four are owned
    Given Albert owns these properties
      | B&O RR                |
      | Reading Railroad      |
      | Pennsylvania Railroad |
      | Short Line            |
    When Fred lands on 'B&O RR'
    Then Fred pays $200 rent to Albert

  Scenario: Landing on Utility
    For Utilities rent is 4x dice if one is owned
    Given Albert owns 'Water Works'
    When Fred lands on 'Water Works'
    Then Fred pays 4x current dice rent to Albert

  Scenario: Landing on Utility when both are owned
    Given Albert owns 'Water Works'
    And Fred owns 'Electric Company'
    When Fred lands on 'Water Works'
    Then Fred pays 10x current dice rent to Albert

  Scenario: Landing on real estate
    Given Albert owns 'Oriental Avenue'
    When Fred lands on 'Oriental Avenue'
    Then Fred pays the stated rent to Albert

  Scenario: Landing on real estate when all in group owned
    Given Albert owns 'Park Place'
    And Albert owns 'Boardwalk'
    When Fred lands on 'Park Place'
    Then Fred pays twice the stated rent to Albert

  Scenario: Landing on real estate
    Given Albert owns 'Oriental Avenue'
    And 'Oriental Avenue' is mortgaged
    When Fred lands on 'Oriental Avenue'
    Then the balance of Fred is unchanged
