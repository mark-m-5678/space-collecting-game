// Enemy class
// Enemies will move towards the player and colliding with them takes away health

class Enemy {
  
  float posX, posY, speed;
  int shipWidth, shipHeight, counter;
  boolean debugMode;
  PImage img1, img2, img3, img4;
  PVector v; // Vector for movement

  Enemy(int posX, int posY, boolean debugMode) {
    // Debug mode
    this.debugMode = debugMode;

    // Ship dimensions
    this.shipWidth = 170/2;
    this.shipHeight = 122/2;

    // Starting position
    this.posX = posX;
    this.posY = posY;

    // Ship speed
    this.speed = 0.5;

    // Load and resize the ship images
    this.img1 = loadImage("img/enemy/enemy_ship_1.png");
    img1.resize(this.shipWidth, this.shipHeight);
    this.img2 = loadImage("img/enemy/enemy_ship_2.png");
    img2.resize(this.shipWidth, this.shipHeight);
    this.img3 = loadImage("img/enemy/enemy_ship_3.png");
    img3.resize(this.shipWidth, this.shipHeight);
    this.img4 = loadImage("img/enemy/enemy_ship_4.png");
    img4.resize(this.shipWidth, this.shipHeight);
  }

  void update() {
    if (this.counter < 10) { 
      image(this.img1, this.posX, this.posY);
    } else if (counter < 20) { 
      image(this.img2, this.posX, this.posY);
    } else if (this.counter < 30) { 
      image(this.img3, this.posX, this.posY);
    } else if (this.counter < 40) { 
      image(this.img4, this.posX, this.posY);
    } else {
      image(this.img4, this.posX, this.posY);
      this.counter = 0;
    }

    // Iterate the counter
    this.counter++;

    if (debugMode) {
      // Debug mode stuff
      textSize(12);
      text("POS: " + this.posX + ", " + this.posY, posX, posY + shipHeight + 20);
      text("DIM: " + this.shipWidth + " x " + this.shipHeight, this.posX, this.posY + shipHeight + 40);
      noFill();
      stroke(255);
      rect(posX, posY, shipWidth, shipHeight);
    }
  }

  void move(Player player) {
    // Move the enemy towards the player (this is probably quite inefficient but... it works! Maybe the maths in CSF really wasn't that uselsess)

    // Get the current co-ordinates of the player ship
    int playerX = player.posX;
    int playerY = player.posY;

    // Create a PVector from the co-ordinates of the player and enemy positions
    // This is based on the formula: u(x,y) = (x2-x1, y2-y1)
    this.v = new PVector(playerX - this.posX, playerY - this.posY);

    // Normalise the vector (make its magnitude = 1)
    v.normalize();

    // Multiply the vector by the speed
    v.mult(speed);

    // Store the newly calculated coordinates in an array (there's no way to just access them directly as far as I can tell)
    float[] newPos = v.array();

    // Find the final new position (calculated vector + original co-ordinates)
    newPos[0] += posX;
    newPos[1] += posY;

    // Move the ship to the newly calculated coordinates
    this.posX = newPos[0];
    this.posY = newPos[1];
  }

  boolean hitPlayer(Player playerShip) {
    // A method that returns if the enemy hit the player ship
    // The expression is checking if the two ships are NOT colliding, I found it to be easier
    if (this.posX+this.shipWidth<playerShip.posX || playerShip.posX+playerShip.shipWidth<this.posX || this.posY+this.shipHeight<playerShip.posY || playerShip.posY+playerShip.shipHeight<this.posY) {
      return false;
    } else {
      // If the statement is false, then they are colliding
      return true;
    }
  }
}
