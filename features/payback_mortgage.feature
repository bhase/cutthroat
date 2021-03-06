Feature: Payback Mortgage
  As a player, I can pay back the mortgage on a property.

  Background:
    Given two player named "John" and "Jane" added to a game

  Scenario: Payback Mortgage
    Given Jane owns 'Park Place'
    And 'Park Place' is mortgaged
    When Jane repays the mortgage for 'Park Place'
    Then 'Park Place' is no longer mortgaged
    And the balance of Jane is decreased by discharge of mortgage of 'Park Place'

  Scenario: Unmortgaged Property
    Given John owns 'Ventnor Avenue'
    When John tries to repay the mortgage for 'Ventnor Avenue'
    Then he should receive a message 'not mortgaged'

  Scenario: Unowned Property
    Given 'Ventnor Avenue' is unowned
    When John tries to repay the mortgage for 'Ventnor Avenue'
    Then he should receive a message 'not your property'

  Scenario: Foreign Property
    Given John owns 'Ventnor Avenue'
    When Jane tries to repay the mortgage for 'Ventnor Avenue'
    Then she should receive a message 'not your property'
