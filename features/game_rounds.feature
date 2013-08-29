Feature: Game Rounds
	As a game I execute a number of rounds so that I can complete a game.

	@draft
	Scenario: Each player plays the same number of turns
		Given a fresh started game
		When 20 rounds are played
		Then each player shall have played the same number of turns

	@draft
	Scenario: Taking turns in order
		Given a fresh started game
		When 20 rounds are played
		Then in each round the order is equal to the iniial order
