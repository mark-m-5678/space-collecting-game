// A class to keep track of the player's score and display it onscreen

class ScoreCounter {
  
  public float posX, posY;
  public int fontSize;
  private int currentScore;

  // Constructor
  ScoreCounter() {

    // Font size and location
    fontSize = 36;
    posX = 20;
    posY = 20 + fontSize;

    // Starting score (= 0)
    currentScore = 0;
  }

  public void display() {
    // Display the score
    textSize(fontSize);
    text("SCORE: " + currentScore, posX, posY);
  }

  public int getScore() {
    return this.currentScore;
  }
  
  public void addScore(int amount) {
    this.currentScore += amount;
  }
}
