# SPACE COLLECTOR
Originally made as a uni asignment. Yes I know that the name is terrible.

## https://github.com/aubergine5678/

## Game art sources:
All game art from opengameart.net:

- https://opengameart.org/content/space-ship-construction-kit
- https://opengameart.org/content/free-ui-asset-pack-1
- https://opengameart.org/content/space-pixel-art

Game font available for non-commercial use from:
- https://www.dafont.com/ethnocentric.font

## Instructions:
- The game launches to a starting splashscreen showing the name of the game and instructions
- Press enter to start the game
- The player is trying to save astonauts stranded in space
- The score increases with every astronaut saved
- There are enemy spaceships that slowly move towards the player
- These have to be avoided - getting hit by one decreases the player's health (shown in the top right)
- If the player gets hit, there is a 3 second cooldown (exactly 180 frames, takes 3 seconds if game is running at 60fps), preventing the player from losing health each frame and immediately dying
- When the player runs out of health a game over screen is displayed, showing how many astronauts the player managed to save

## Development notes:

### Class explenation:
- "Player" class: class for the player ship which is animated from a sequence of 6 images. It can move up, down, left and right with the move() method.
- "Astronaut" class: a class for the "collectables" - astronauts which the player is trying to save. Each astronaut gets a random location. Every astronaut object is checking if it has been saved by the player ship using the saved() method.
- "Enemy" class: a class for the enemies which chase the player. These are animated from a sequence of 4 images. Each enemy object is constantly calculating a movement vector based on the location of the player to move towards them. They are also checking if they collided with the player.
- "ScoreCounter" class: a simple class to hold and display the current score
- "HealthCounter" class: a class to store and show the current health (health is displayed by one of 6 images - the player has 6 lives)

*(Further details provided as comments in the source code)*

**DEBUG MODE:**
- Originally only a temporary mode used for development, but I decided to leave it in as an optional graphical mode
- Enableing "debug mode" will display the rectangular hitboxes for all objects onscreen, as well as a few other useful information for testing the game
- Enabled by changing the "debugMode" variable in the source code to TRUE

## File structure:
```
*[root_dir] space_collecting_game
	|--- *(dir) img 
	|	|--- *(dir) astronaut
	|	|	L--- astronaut.png
	|	|--- *(dir) enemy
	|	|	|--- enemy_ship_1.png
	|	|	|--- enemy_ship_2.png
	|	|	|--- enemy_ship_3.png
	|	|	L--- enemy_ship_4.png
	|	|--- *(dir) healthBar
	|	|	|--- health.afphoto
	|	|	|--- health_0.png
	|	|	|--- health_1.png
	|	|	|--- health_2.png
	|	|	|--- health_3.png
	|	|	|--- health_4.png
	|	|	|--- health_5.png
	|	|	L--- health_6.png
	|	|--- *(dir) player
	|	|	|--- player_ship.afphoto
	|	|	|--- player_ship_1.png
	|	|	|--- player_ship_2.png
	|	|	|--- player_ship_3.png
	|	|	|--- player_ship_4.png
	|	|	|--- player_ship_5.png
	|	|	L--- player_ship_6.png
	|	|--- background.afphoto
	|	|--- background.png
	|	|--- game_over_screen.png
	|	L--- start_screen.png
	|--- space_collecting_game.pde
	|--- classPlayer.pde
	|--- classAstronaut.pde
	|--- classEnemy.pde
	|--- classScoreCounter.pde
	|--- classHealthCounter.pde
	|--- enum.pde
	|--- readme.md
	L--- readme.html
```
