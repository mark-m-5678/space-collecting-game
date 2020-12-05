// A class to keep track of the player's score and display it onscreen

class ScoreCounter {
  
  int posX, posY, fontSize, currentScore;
  boolean debugMode;

  // Constructor
  ScoreCounter(boolean debugMode) {
    this.debugMode = debugMode;

    // Font size and location
    fontSize = 36;
    posX = 20;
    posY = 20 + fontSize;

    // Starting score (= 0)
    currentScore = 0;
  }

  void display() {
    // Display the score
    textSize(fontSize);
    text("SCORE: " + currentScore, posX, posY);
  }
}
