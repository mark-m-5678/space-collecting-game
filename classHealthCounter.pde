// Health counter class (used to display the player's remaining health in the top right corner)

class HealthCounter {
  
  int posX, posY, currentHealth, imgWidth, imgHeight;
  PImage img0, img1, img2, img3, img4, img5, img6;
  boolean debugMode;

  HealthCounter(boolean debugMode) {
    this.debugMode = debugMode;

    // Image dimensions
    this.imgWidth = 233;
    this.imgHeight = 77;

    // Image position
    this.posX = width - this.imgWidth - 20;
    this.posY = 20;

    // Starting health (= 6)
    this.currentHealth = 6;

    // Load and resize images
    this.img0 = loadImage("img/healthBar/health_0.png");
    img0.resize(this.imgWidth, this.imgHeight);
    this.img1 = loadImage("img/healthBar/health_1.png");
    img1.resize(this.imgWidth, this.imgHeight);
    this.img2 = loadImage("img/healthBar/health_2.png");
    img2.resize(this.imgWidth, this.imgHeight);
    this.img3 = loadImage("img/healthBar/health_3.png");
    img3.resize(this.imgWidth, this.imgHeight);
    this.img4 = loadImage("img/healthBar/health_4.png");
    img4.resize(this.imgWidth, this.imgHeight);
    this.img5 = loadImage("img/healthBar/health_5.png");
    img5.resize(this.imgWidth, this.imgHeight);
    this.img6 = loadImage("img/healthBar/health_6.png");
    img6.resize(this.imgWidth, this.imgHeight);
  }

  void display() {
    switch(this.currentHealth) {
    case 0:
      // No HP remaining
      image(this.img0, this.posX, this.posY);
      break;
    case 1:
      // 1 HP remaining
      image(this.img1, this.posX, this.posY);
      break;
    case 2:
      // 2 HP remaining
      image(this.img2, this.posX, this.posY);
      break;
    case 3:
      // 3 HP remaining
      image(this.img3, this.posX, this.posY);
      break;
    case 4:
      // 4 HP remaining
      image(this.img4, this.posX, this.posY);
      break;
    case 5:
      // 5 HP remaining
      image(this.img5, this.posX, this.posY);
      break;
    case 6:
      // 6 Health remaining
      image(this.img6, this.posX, this.posY);
      break;
    default:
      // If the health is negative, still display 0
      image(this.img0, this.posX, this.posY);
      break;
    }
    if (debugMode) {
      // Debug mode stuff
      textSize(12);
      text("HP: " + this.currentHealth, this.posX, this.posY + this.imgHeight + 20);
      text("DIM: " + this.imgWidth + " x " + this.imgHeight, this.posX, this.posY + imgHeight + 40);
      noFill();
      stroke(255);
      rect(this.posX, this.posY, this.imgWidth, this.imgHeight);
    }
  }
}
