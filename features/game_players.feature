Feature: Game players
	As a game, I can have between two and eight players
	with an initial random ordering.

	Scenario: Two player
		Given two player named 'Horse' and 'Car'
		When I start a game
		Then a game with 'Horse' and 'Car' should exist

	Scenario: Too few player
		Given one player 'Car'
		When I start a game
		Then I should receive a message 'too few player'
		And no game exists

	Scenario: Too many player
		Given nine player
		When I start a game
		Then I should receive a message 'too many player'
		And no game exists

	Scenario: Initial ordering
		Given two player named 'Horse' and 'Car'
		When I start a game 100 times
		Then 'Horse' and 'Car' both have been the starting player
