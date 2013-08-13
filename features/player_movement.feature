Feature: Player movement
	As a player, I can take a turn so that I can move around the board.

	Scenario: Standard move
		Given a player on location 0
		When the player rolls 7
		Then the player shall end on location 7

	Scenario: Turn around
		Given a player on location 39
		When the player rolls 6
		Then the player shall end on location 5
