Feature: Payback Mortgage
  As a player, I can pay back the mortgage on a property.

  Background:
    Given two player named 'John' and 'Jane' added to a game

  @wip
  Scenario: Payback Mortgage
    Given Jane owns 'Park Place'
    And 'Park Place' is mortgaged
    When Jane repays the mortgage for 'Park Place'
    Then 'Park Place' is no longer mortgaged
    And the balance of Jane is decreased by price of 'Park Place'

  @draft
  Scenario: Unmortgaged Property
    Given John owns 'Ventnor Avenue'
    When John tries to repay the mortgage for 'Ventnor Avenue'
    Then he should receive a message 'not mortgaged'

  @draft
  Scenario: Unowned Property
    Given 'Ventnor Avenue' is unowned
    When John player tries to repay the mortgage for 'Ventnor Avenue'
    Then he receive a message 'not your property'

  @draft
  Scenario: Foreign Property
    Given 'Ventnor Avenue' is owned by John
    When Jane tries to repay the mortgage for 'Ventnor Avenue'
    Then she should receive a message 'not your property'
