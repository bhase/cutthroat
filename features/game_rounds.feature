Feature: Game Rounds
	As a game I execute a number of rounds so that I can complete a game.

	@draft
	Scenario: Each player plays the same number of turns
		Given a fresh started game
		When the game is cancelled after 20 rounds
		Then all players shall have played the same number of turns

	@draft
	Scenario: Taking turns in order
		Given a fresh started game
		When the game is cancelled after 20 rounds
		Then in each round the player order has been equal to the iniial order
