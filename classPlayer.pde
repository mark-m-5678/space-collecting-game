// Player class
// Player can move up, down, left and right
// The player ship is animated from a 6 image sequence

class Player {
  
  int posX, posY, moveSpeed, counter, shipWidth, shipHeight;
  boolean debugMode;
  PImage img1, img2, img3, img4, img5, img6;

  Player (int startingPosX, int startingPosY, boolean debugMode) {
    this.debugMode = debugMode;

    this.posX = startingPosX;
    this.posY = startingPosY;

    // How far the player ship moves in one button press:
    this.moveSpeed = 20;

    // Dimensions of the player ship:
    this.shipWidth = 91;
    this.shipHeight = 145;

    // Load and resize the ship images
    this.img1 = loadImage("img/player/player_ship_1.png");
    img1.resize(this.shipWidth, this.shipHeight);
    this.img2 = loadImage("img/player/player_ship_2.png");
    img2.resize(this.shipWidth, this.shipHeight);
    this.img3 = loadImage("img/player/player_ship_3.png");
    img3.resize(this.shipWidth, this.shipHeight);
    this.img4 = loadImage("img/player/player_ship_4.png");
    img4.resize(this.shipWidth, this.shipHeight);
    this.img5 = loadImage("img/player/player_ship_5.png");
    img5.resize(this.shipWidth, this.shipHeight);
    this.img6 = loadImage("img/player/player_ship_6.png");
    img6.resize(this.shipWidth, this.shipHeight);
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
    } else if (this.counter < 50) {
      image(this.img5, this.posX, this.posY);
    } else if (this.counter < 60) {
      image(this.img6, this.posX, this.posY);
    } else {
      image(this.img6, this.posX, this.posY);
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

  void move(Direction moveDirection) {
    switch(moveDirection) {
    case UP:
      // Move UP
      posY -= moveSpeed;
      break;
    case RIGHT:
      // Move RIGHT
      posX += moveSpeed;
      break;
    case DOWN:
      // Move DOWN
      posY += moveSpeed;
      break;
    case LEFT:
      // Move LEFT
      posX -= moveSpeed;
      break;
    }
  }
}
