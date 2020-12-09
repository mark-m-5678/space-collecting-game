// Spaceship superclass - the player ship and enemy ships inherit from this class

class Spaceship {
  
  public int shipWidth, shipHeight, counter;
  public float posX, posY, speed;

  // Constructor (float, float) - for specifying the starting co-ordinates
  Spaceship(float posX, float posY) {
    this.posX = posX;
    this.posY = posY;
  }
  
  // Constructor which picks a random starting location
  Spaceship() {
    this.posX = random(width);
    this.posY = random(height);
  }

  public int getWidth() {
    return shipWidth;
  }

  public int getHeight() {
    return shipHeight;
  }
  
  public void setDimensions(int shipWidth, int shipHeight) {
    this.shipWidth = shipWidth;
    this.shipHeight = shipHeight;
  }
}
