/*
 "Space Collector" - coursework
 aubergine5678
 --------------------------------------------------------------------------------
 
 Game art sources:
 https://opengameart.org/content/space-ship-construction-kit
 https://opengameart.org/content/free-ui-asset-pack-1
 https://opengameart.org/content/space-pixel-art
 
 --------------------------------------------------------------------------------
 */

PImage background, startScreen, gameOverScreen; // Background and start/game over screens
HealthCounter healthCounter; // Health counter
ScoreCounter scoreCounter; // Score counter
Player player1; // Player

boolean cooldown; // Cooldown mode (a brief moment of invincibility after the player takes damage)
int cooldownTimer; // A counter to keep track of the cooldown duration

ArrayList<Astronaut> astronautList = new ArrayList(); // Create an empty ArrayList to store astronauts
ArrayList<Enemy> enemyList = new ArrayList(); // Create an empty ArrayList to store enemies

// Set the game state (game begins on the starting screen):
GameState currentGameState = GameState.START_SCREEN;

// ------------------------------------------------------------------------------
// DEBUG MODE:
// Displays hitboxes, the coordinates and dimensions of all objects on screen - used for development purposes
// (WARNING: Makes the game slow to start)
// (off by default)
   boolean debugMode = true;
// ------------------------------------------------------------------------------

void setup() {

  // Set screen size (720p by default)
  size(1280, 720);

  // Load background image
  background = loadImage("img/background.png");
  background.resize(width, height);

  // Load the start and game over screens
  startScreen = loadImage("img/start_screen.png");
  startScreen.resize(width, height);
  gameOverScreen = loadImage("img/game_over_screen.png");
  gameOverScreen.resize(width, height);

  // Create the player
  player1 = new Player(width/2, height/2, debugMode);

  // Populate the ArrayList with 5 astronaut objects
  for (int i = 0; i < 5; i++) {
    astronautList.add(new Astronaut(debugMode));
  }

  // Populate the ArrayList with 3 enemy objects with pre-determined positions
  enemyList.add(new Enemy(50, 100, debugMode));
  enemyList.add(new Enemy(width - 100, 100, debugMode));
  enemyList.add(new Enemy(width/2, height - 100, debugMode));

  // Create the health counter
  healthCounter = new HealthCounter(debugMode);

  // Create the score counter
  scoreCounter = new ScoreCounter(debugMode);
}

void draw() {
  // Chance gameState to Game Over if player has run out of lives
  if (healthCounter.currentHealth == 0) {
    //gameState = GAME_OVER;
    currentGameState = GameState.GAME_OVER;
  }

  // Main gameState if statement
  if (currentGameState == GameState.START_SCREEN) {
    // Show start screen
    image(startScreen, 0, 0);
  } else if (currentGameState == GameState.PLAYING) {
    // Game is playing
    // Clear background
    image(background, 0, 0);

    // Show health and score
    healthCounter.display();
    scoreCounter.display();

    // Update player ship
    player1.update();

    // Update all astronaut objects
    for (int i = 0; i < astronautList.size(); i++) {
      astronautList.get(i).display();

      // Check for every astronaut if they are saved by the player
      if (astronautList.get(i).saved(player1)) {
        // Player saved an astronaut
        // println("Player saved astronaut number " + i);
        scoreCounter.currentScore += 1;
        astronautList.remove(i);
        astronautList.add(new Astronaut(debugMode));
      }
    }

    // Update all enemy objects
    for (int i = 0; i < enemyList.size(); i++) {
      enemyList.get(i).update();
      enemyList.get(i).move(player1);

      // If in cooldown mode, wait ~3 seconds (180 frames) before checking for collisions again
      if (cooldown && cooldownTimer < 180) {
        // Wait
        cooldownTimer += 1;
      } else if (cooldown && cooldownTimer == 180) {
        // If timer has reached 180, reset it and check for collisions again
        cooldownTimer = 0;
        cooldown = false;
      } else if (enemyList.get(i).hitPlayer(player1)) {
        // Player was hit by an enemy
        // println("Player was hit");
        healthCounter.currentHealth -= 1;
        cooldown = true;
      }
    }

    if (debugMode) {
      // Debug mode stuff
      textSize(12);
      text("Number of ships: " + 1, width/2, 20);
      text("Number of astronauts: " + astronautList.size(), width/2, 40);
      text("Number of astonauts saved: " + scoreCounter.currentScore, width/2, 60);
    }
  } else if (currentGameState == GameState.GAME_OVER) {
    // Show game over screen
    image(gameOverScreen, 0, 0);

    // Set text alignment and size
    textAlign(CENTER, CENTER);
    textSize(36);

    // Print the correct game over message
    switch (scoreCounter.currentScore) {
    case 0:
      // Player didn't save any astonauts
      text("You didn't manage to save any astronauts.", width/2, height/2);
      break;
    case 1:
      // Player saved 1 astronaut
      text("You managed to save 1 astronaut.", width/2, height/2);
      break;
    default:
      // Player saved more than 1 astronaut
      text("You managed to save " + scoreCounter.currentScore + " astronauts.", width/2, height/2);
      break;
    }
  }
}

void keyPressed() {
  if (key == ENTER && currentGameState == GameState.START_SCREEN) {
    // If the game has't started and the player presses return, set the gameState to "Playing"
    currentGameState = GameState.PLAYING;
  } else if (key == ENTER && currentGameState == GameState.GAME_OVER) {
    // If the game is over and the player presses return, exit the program
    exit();
  } else if (key == TAB) {
    // TEMPORARY - used for testing
    // healthCounter.currentHealth -= 1;
  } else if (key == CODED) {
    // Player movement
    if (keyCode == UP && player1.posY > 0) {
      // Move player up
      player1.move(Direction.UP);
    } else if (keyCode == RIGHT && player1.posX < width - player1.shipWidth) {
      // Move player right
      player1.move(Direction.RIGHT);
    } else if (keyCode == DOWN && player1.posY < height - player1.shipHeight) {
      // Move player down
      player1.move(Direction.DOWN);
    } else if (keyCode == LEFT && player1.posX > 0) {
      // Move player left
      player1.move(Direction.LEFT);
    }
  }
}
