
final int LINES_PER_LEVEL = 10;
int RECTANGLE_COLOR = 155;
int TEXT_COLOR = 255;
int TEXT_SIZE = 14;

class Menu {
 
  int score;
  int level;
  int lines; 
  int linesIncrease;
  int dropSpeed;
  
  Menu() { //Menu Constructor
    score = 0;
    level = 0;
    lines = 0;
    linesIncrease = 0;
    setDropSpeed();
  }
  
  void show() {
    
    fill(RECTANGLE_COLOR);
    rect(450, 120, 80, 20); //Next Block Rectangle
    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(CENTER, TOP);
    text("Next block:", 490, 120); //Next Block Text
    
    fill(RECTANGLE_COLOR);
    rect(450, 250, 80, 20); //Held Block Rectangle
    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(CENTER, TOP);
    text("Held block:", 490, 250); //Held Block Text
    
    fill(RECTANGLE_COLOR);
    rect(70, 120, 120, 30); //Score Rectangle
    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(LEFT, CENTER);
    text("Score: " + score, 75, 135); //Score Text
    
    
    fill(RECTANGLE_COLOR);
    rect(70, 180, 120, 30); //Level Rectangle
    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(LEFT, CENTER);
    text("Level: " + level, 75, 195); //Level Text
    
    fill(RECTANGLE_COLOR);
    rect(70, 240, 120, 30); //Lines Rectangle
    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(LEFT, CENTER);
    text("Lines: " + lines, 75, 255); //Lines Text
    
    fill(RECTANGLE_COLOR);
    rect(70, 300, 120, 205); //Lines Rectangle
    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(CENTER, TOP);
    text("Controls", 130, 300); //Controls Text
    textAlign(LEFT, CENTER);
    text("'a' --> Left", 75, 335);
    text("'d' --> Right", 75, 360);
    text("'w' --> Rotate", 75, 385);
    text("'s' --> Fall", 75, 410);
    text("'e' --> Hold", 75, 435);
    text("'q' --> Start", 75, 460);
    text("'f' --> Pause", 75, 485);
  }
  
  void showStart() {
    fill(RECTANGLE_COLOR);
    rect(235, 305, 170, 30); //Lines Rectangle
    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(LEFT, CENTER);
    text("Press 'q' to begin game", 240, 320); //Lines Text
  }
  
  void showPause() {
    fill(RECTANGLE_COLOR);
    rect(230, 305, 180, 30); //Lines Rectangle
    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(LEFT, CENTER);
    text("Press 'q' to resume game", 235, 320); //Lines Text
  }
  
  void showGameOver() {
    fill(RECTANGLE_COLOR);
    rect(235, 270, 170, 100); //Lines Rectangle
    fill(TEXT_COLOR);
    textSize(TEXT_SIZE);
    textAlign(CENTER, TOP);
    text("GAME OVER", 320, 275); //Lines Text
    text("Press 'q' to restart", 320, 310); //Lines Text
    text("Press 'f' to exit", 320, 345); //Lines Text
  }
  
  int getScore() {
    return score;
  }
  
  int getLevel() {
    return level;  
  }
  
  int getLines() {
    return lines;  
  }
  
  int getDropSpeed(){
    return dropSpeed;  
  }
  
  void scoreUp(int change){
    score += change;  
  }
  
  void scoreUpLineClear(int linesCleared) {
    switch(linesCleared){
      case(1):
        score += 40 * (level + 1);
        break; 
        
      case(2):
        score += 100 * (level + 1);
        break;
        
      case(3):
        score += 300 * (level + 1);
        break;
        
      case(4):
        score += 1200 * (level + 1);
        break;
    }
  }
  
  void lineChange(int change) {
    lines += change;
    linesIncrease += change;
    
    if(linesIncrease / LINES_PER_LEVEL >= 1){
        level++;
        setDropSpeed();
        linesIncrease -= LINES_PER_LEVEL;
    }
  }
  
  
  
  void setDropSpeed() {
    switch(level){
      case(0):
        dropSpeed = 48;
        break;
      case(1):
        dropSpeed = 43;
        break;
      case(2):
        dropSpeed = 38;
        break;
      case(3):
        dropSpeed = 33;
        break;
      case(4):
        dropSpeed = 28;
        break;
      case(5):
        dropSpeed = 23;
        break;
      case(6):
        dropSpeed = 18;
        break;
      case(7):
        dropSpeed = 13;
        break;
      case(8):
        dropSpeed = 8;
        break;
      case(9):
        dropSpeed = 6;
        break;
      case(10):
        dropSpeed = 5;
        break;
      case(13):
        dropSpeed = 4;
        break;
      case(16):
        dropSpeed = 3;
        break;
      case(19):
        dropSpeed = 2;
        break;
      case(29):
        dropSpeed = 1;
        break;
    }
  }
  
}
