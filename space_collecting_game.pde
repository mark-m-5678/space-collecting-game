/*
 aubergine5678
 --------------------------------------------------------------------------------
 
 Game art sources:
 https://opengameart.org/content/space-ship-construction-kit
 https://opengameart.org/content/free-ui-asset-pack-1
 https://opengameart.org/content/space-pixel-art
 
 --------------------------------------------------------------------------------
 */

public PImage background, startScreen, gameOverScreen; // Background and start/game over screens
public HealthCounter healthCounter; // Health counter
public ScoreCounter scoreCounter; // Score counter
public Player player1; // Player

public boolean cooldown; // Cooldown mode (a brief moment of invincibility after the player takes damage)
public int cooldownTimer; // A counter to keep track of the cooldown duration

public ArrayList<Astronaut> astronautList = new ArrayList(); // Create an empty ArrayList to store astronauts
public ArrayList<Enemy> enemyList = new ArrayList(); // Create an empty ArrayList to store enemies

// Set the game state (game begins on the starting screen):
public GameState currentGameState = GameState.START_SCREEN;

// ------------------------------------------------------------------------------
// DEBUG MODE:
// Displays hitboxes, the coordinates and dimensions of all objects on screen - used for testing
// (off by default)
   public boolean debugMode = false;
// ------------------------------------------------------------------------------

void setup() {

  // Set screen size (720p by default)
  size(1280, 720);

  // Lock the framerate to 60fps
  frameRate(60);

  // Load background image
  background = loadImage("img/background.png");
  background.resize(width, height);

  // Load the start and game over screens
  startScreen = loadImage("img/start_screen.png");
  startScreen.resize(width, height);
  gameOverScreen = loadImage("img/game_over_screen.png");
  gameOverScreen.resize(width, height);

  // Create the player
  player1 = new Player(width/2, height/2);

  // Populate the ArrayList with 5 astronaut objects
  for (int i = 0; i < 5; i++) {
    astronautList.add(new Astronaut());
  }

  // Populate the ArrayList with 3 enemy objects with pre-determined positions
  enemyList.add(new Enemy(50, 100));
  enemyList.add(new Enemy(width - 100, 100));
  enemyList.add(new Enemy(width/2, height - 100));

  // Create the health counter
  healthCounter = new HealthCounter();

  // Create the score counter
  scoreCounter = new ScoreCounter();
}

void draw() {
  // Chance gameState to Game Over if player has run out of lives
  if (healthCounter.getHealth() == 0) {
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
        scoreCounter.addScore(1);
        astronautList.remove(i);
        astronautList.add(new Astronaut());
      }
    }

    // Update all enemy objects
    for (int i = 0; i < enemyList.size(); i++) {
      enemyList.get(i).update();
      enemyList.get(i).move(player1);

      // If in cooldown mode, wait 180 frames before checking for collisions again
      if (cooldown && cooldownTimer < 180) {
        // Wait
        cooldownTimer += 1;
      } else if (cooldown && cooldownTimer == 180) {
        // If timer has reached 180, reset it and check for collisions again
        cooldownTimer = 0;
        cooldown = false;
      } else if (enemyList.get(i).hitPlayer(player1)) {
        // Player was hit by an enemy
        healthCounter.addDamage(1);
        cooldown = true;
      }
    }

    if (debugMode) {
      // Debug mode stuff
      textSize(12);
      text("Number of ships: " + 1, width/2, 20);
      text("Nunber of enemies: " + enemyList.size(), width/2, 40);
      text("Number of astronauts: " + astronautList.size(), width/2, 60);
      text("Number of astronauts saved: " + scoreCounter.getScore(), width/2, 80);
    }
  } else if (currentGameState == GameState.GAME_OVER) {
    // Show game over screen
    image(gameOverScreen, 0, 0);

    // Set text alignment and size
    textAlign(CENTER, CENTER);
    textSize(36);

    // Print the correct game over message
    switch (scoreCounter.getScore()) {
    case 0:
      // Player didn't save any astronauts
      text("You didn't save any astronauts.", width/2, height/2);
      break;
    case 1:
      // Player saved 1 astronaut
      text("You saved one astronaut.", width/2, height/2);
      break;
    default:
      // Player saved more than 1 astronaut
      text("You saved " + scoreCounter.getScore() + " astronauts.", width/2, height/2);
      break;
    }
  }
}

void keyPressed() {
  if (key == ENTER && currentGameState == GameState.START_SCREEN) {
    // If the game has't started and the player presses enter, set the gameState to "Playing"
    currentGameState = GameState.PLAYING;
  } else if (key == ENTER && currentGameState == GameState.GAME_OVER) {
    // If the game is over and the player presses enter, exit the program
    exit();
  } else if (key == CODED) {
    // Player movement
    if (keyCode == UP && player1.posY > 0) {
      player1.move(Direction.UP);
    } else if (keyCode == RIGHT && player1.posX < width - player1.shipWidth) {
      player1.move(Direction.RIGHT);
    } else if (keyCode == DOWN && player1.posY < height - player1.shipHeight) { 
      player1.move(Direction.DOWN);
    } else if (keyCode == LEFT && player1.posX > 0) {
      player1.move(Direction.LEFT);
    }
  }
}
