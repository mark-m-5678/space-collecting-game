// The astronauts are "collectables" - the player is trying to save them

class Astronaut {
  
  private int posX, posY, imgWidth, imgHeight;
  private PImage img;

  Astronaut () {

    // Image dimensions
    this.imgWidth = 377/8;
    this.imgHeight = 297/8;

    // Astronaut position
    this.posX = (int)random(width - this.imgWidth - 20);
    this.posY = (int)random(117, height - this.imgHeight - 20);

    // Load and resize image
    this.img = loadImage("img/astronaut/astronaut.png");
    img.resize(this.imgWidth, this.imgHeight);
  }

  public void display() {
    image(this.img, this.posX, this.posY);
    if (debugMode) {
      // Debug mode stuff
      textSize(12);
      text("POS: " + this.posX + ", " + this.posY, posX, posY + imgHeight + 20);
      text("DIM: " + this.imgWidth + " x " + this.imgHeight, this.posX, this.posY + imgHeight + 40);
      noFill();
      stroke(255);
      rect(this.posX, this.posY, this.imgWidth, this.imgHeight);
    }
  }

  public boolean saved(Player playerShip) {
    // Method that returns if the astronaut has been saved by the player ship

    if (this.posX+this.imgWidth<playerShip.posX || playerShip.posX+playerShip.shipWidth<this.posX || this.posY+this.imgHeight<playerShip.posY || playerShip.posY+playerShip.shipHeight<this.posY) {
      return false;
    } else {
      return true;
    }
  }
}
