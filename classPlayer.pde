// Player class
// Player can move up, down, left and right

class Player extends Spaceship {

  // Player ship is animated from a sequence of 6 images:
  private PImage img1, img2, img3, img4, img5, img6;

  Player (int startingPosX, int startingPosY) {
    super(startingPosX, startingPosY);

    // How far the player ship moves in one button press:
    this.speed = 20;

    // Dimensions of the player ship:
    this.setDimensions(91, 145);

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

  public void update() {
    if (this.counter < 10) { 
      image(this.img1, this.posX, this.posY);
    } else if (this.counter < 20) { 
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

  public void move(Direction moveDirection) {
    switch(moveDirection) {
    case UP:
      // Move UP
      posY -= this.speed;
      break;
    case RIGHT:
      // Move RIGHT
      posX += this.speed;
      break;
    case DOWN:
      // Move DOWN
      posY += this.speed;
      break;
    case LEFT:
      // Move LEFT
      posX -= this.speed;
      break;
    }
  }
}
