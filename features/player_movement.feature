Feature: Player movement
	As a player, I can take a turn so that I can move around the board.

	Scenario: Standard move
		Given a player on 'Go'
		When the player rolls 3
		Then the player shall end on 'Baltic Avenue'

	Scenario: Turn around
		Given a player on 'Boardwalk'
		When the player rolls 7
		Then the player shall end on 'Oriental Avenue'
