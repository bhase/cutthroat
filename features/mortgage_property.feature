Feature: Mortgage Property
  As a player I can mortgage property during my turn

  Background:
    Given two player named "Albert" and "Fred" added to a game

  Scenario: Mortgage Property
    Given Fred owns 'Oriental Avenue'
    When Fred mortgages 'Oriental Avenue'
    Then the balance of Fred is increased by mortgage rate of 'Oriental Avenue'
    And 'Oriental Avenue' shall be mortgaged

  Scenario: Try to Mortgage Already Mortgaged Property
    Given Albert owns 'Reading Railroad'
    And 'Reading Railroad' is already mortgaged
    When Albert tries to mortgage 'Reading Railroad'
    Then Albert should receive a message 'already mortgaged'
    And the balance of Albert is unchanged

  Scenario: Try to Mortgage Unowned Property
    Given 'Tennessee Avenue' is unowned
    When Fred tries to mortgage 'Tennessee Avenue'
    Then Fred should receive a message 'not your property'
    And the balance of Fred is unchanged

  Scenario: Try to Mortgage Foreign Property
    Given Fred owns 'States Avenue'
    When Albert tries to mortgage 'States Avenue'
    Then Albert should receive a message 'not your property'
    And the balance of Albert is unchanged

  Scenario: Try to Mortgage Property with Buildings
    Given Fred owns 'Vermont Avenue' with one house
    When Fred tries to mortgage 'Vermont Avenue'
    Then Fred should receive a message 'cannot mortgage with buildings'
    And the balance of Fred is unchanged

  @draft
  Scenario: Try to Mortgage Property with Buildings in Group
    Given Albert owns 'Atlantic Avenue'
    And Albert owns all other properties in the group of 'Atlantic Avenue' with two houses
    When Albert tries to morgage 'Atlantic Avenue'
    Then Albert should receive a message 'cannot mortgage with buildings'
    And the balance of Albert is unchanged
