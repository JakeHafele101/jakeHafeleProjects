import java.util.Random;

final int SPEED_ACROSS = 5;
final int SPEED_DOWN = 40;
final int SPEED_ROTATE = 10;

final int STATE_START = 0;
final int STATE_PLAYING = 1;
final int STATE_PAUSE = 2;
final int STATE_OVER = 3;

Menu menu;
Grid grid;
Grid heldGrid;
Grid nextGrid;
Block currentBlock;
Block nextBlock;
Block heldBlock;

int currentBlockValue;
int nextBlockValue;
int heldBlockValue;

int gameState;

boolean rotate, left, right, fallFast, switchBlock, start, pause;
boolean hasSwitched;

void setup() {
  size(640, 640); //Screen Resolution
  background(90, 90, 90); //Sets Background Color
  menu = new Menu();
  grid = new Grid(12, 25, 200, 40, 20, 155, 155, 155, 90, 90, 90, false);
  nextGrid = new Grid(4, 2, 450, 140, 20, 155, 155, 155, 90, 90, 90, true);
  heldGrid = new Grid(4, 2, 450, 270, 20, 155, 155, 155, 90, 90, 90, true);
  currentBlockValue = 0;
  heldBlockValue = -1;
  nextBlock(currentBlockValue);
  nextBlockAfter();
  hasSwitched = false;
  gameState = STATE_START;
}

void draw() {
  
  switch(gameState){
    case(STATE_START):
      stateStart();
      break;
      
    case(STATE_PLAYING):
      statePlaying();
      break;
      
    case(STATE_PAUSE):
      statePause();
      break;
      
    case(STATE_OVER):
      stateOver();
      break;
  } //<>//
}

void stateStart(){
  menu.showStart();
  if(start){
    gameState = STATE_PLAYING;
  }
}

void statePlaying(){
  menu.show();
  grid.show();
  heldGrid.show();
  nextGrid.show();
  grid.checkClear();
  
  if(grid.isGameOver()){
    gameState = STATE_OVER;
  }
  
  if(fallFast && frameCount % (SPEED_DOWN / 10) == 0) {
    currentBlock.fall();  
  }
  
  else if(frameCount % SPEED_DOWN == 0){
    currentBlock.fall();  
  }
  
  if(currentBlock.hitSolid()){
    menu.scoreUp(5);
    grid.cleanPlaying();
    nextBlock(nextBlockValue);
    nextGrid.resetMap();
    nextBlockAfter();
  }
  
  if(right && frameCount % SPEED_ACROSS == 0){
    currentBlock.moveRight();
  }
  
  if(left && frameCount % SPEED_ACROSS == 0){
    currentBlock.moveLeft();
  }
  
  if(rotate && frameCount % SPEED_ROTATE == 0){
    currentBlock.rotate();
  }
  
  if(switchBlock && heldBlockValue == -1){
    heldBlockValue = currentBlockValue;
    currentBlockValue = nextBlockValue;
    nextGrid.resetMap();
    nextBlockAfter();
    nextBlockHeld(heldBlockValue);
    currentBlock.clearBlock();
    nextBlock(currentBlockValue);
  }
  else if(switchBlock && frameCount % 30 == 0){
    int temp = currentBlockValue;
    currentBlockValue = heldBlockValue;
    heldBlockValue = temp;
    heldGrid.resetMap();
    nextBlockHeld(heldBlockValue);
    currentBlock.clearBlock();
    nextBlock(currentBlockValue);
  }
  
  if(pause){
    gameState = STATE_PAUSE;  
  }
}

void statePause(){
  menu.showPause();
  if(start){
    gameState = STATE_PLAYING;  
  }
}

void stateOver(){
  menu.show();
  menu.showGameOver();
  if(pause){
    exit();  
  }
  if(start){
    resetGame();
    gameState = STATE_START;
  }
}

void resetGame(){
  menu = new Menu();
  grid = new Grid(12, 25, 200, 40, 20, 155, 155, 155, 90, 90, 90, false);
  nextGrid = new Grid(4, 2, 450, 140, 20, 155, 155, 155, 90, 90, 90, true);
  heldGrid = new Grid(4, 2, 450, 270, 20, 155, 155, 155, 90, 90, 90, true);
  currentBlockValue = 0;
  heldBlockValue = -1;
  nextBlock(currentBlockValue);
  nextBlockAfter();
  hasSwitched = false;
}

void nextBlock(int value) {
  switch(value){
    case 0:
      currentBlock = new I(grid, 4, 3);
      break;
      
    case 1:
      currentBlock = new J(grid, 4, 3);
      break;
      
    case 2:
      currentBlock = new L(grid, 4, 3);
      break;
      
    case 3:
      currentBlock = new O(grid, 5, 3);
      break;
      
    case 4:
      currentBlock = new S(grid, 4, 3);
      break;
      
    case 5:
      currentBlock = new T(grid, 4, 3);
      break;
      
    case 6:
      currentBlock = new Z(grid, 4, 3);
      break;
  }
}

void nextBlockAfter() {
  switch(int(random(7))){
    case 0:
      nextBlock = new I(nextGrid, 0, 1);
      nextBlockValue = 0;
      break;
      
    case 1:
      nextBlock = new J(nextGrid, 0, 1);
      nextBlockValue = 1;
      break;
      
    case 2:
      nextBlock = new L(nextGrid, 0, 1);
      nextBlockValue = 2;
      break;
      
    case 3:
      nextBlock = new O(nextGrid, 1, 1);
      nextBlockValue = 3;
      break;
      
    case 4:
      nextBlock = new S(nextGrid, 0, 1);
      nextBlockValue = 4;
      break;
      
    case 5:
      nextBlock = new T(nextGrid, 0, 1);
      nextBlockValue = 5;
      break;
      
    case 6:
      nextBlock = new Z(nextGrid, 1, 1);
      nextBlockValue = 6;
      break;
  }
}

void nextBlockHeld(int value) {
  switch(value){
    case 0:
      heldBlock = new I(heldGrid, 0, 1);
      heldBlockValue = 0;
      break;
      
    case 1:
      heldBlock = new J(heldGrid, 0, 1);
      heldBlockValue = 1;
      break;
      
    case 2:
      heldBlock = new L(heldGrid, 0, 1);
      heldBlockValue = 2;
      break;
      
    case 3:
      heldBlock = new O(heldGrid, 1, 1);
      heldBlockValue = 3;
      break;
      
    case 4:
      heldBlock = new S(heldGrid, 0, 1);
      heldBlockValue = 4;
      break;
      
    case 5:
      heldBlock = new T(heldGrid, 0, 1);
      heldBlockValue = 5;
      break;
      
    case 6:
      heldBlock = new Z(heldGrid, 1, 1);
      heldBlockValue = 6;
      break;
  }
}
  
  void keyPressed() {
    if (key == 'w') rotate = true;
    if (key == 'a') left = true;
    if (key == 'd') right = true;
    if (key == 's') fallFast = true;
    if (key == 'e') switchBlock = true;
    if (key == 'q') start = true;
    if (key == 'f') pause = true;
  }
    
  
  void keyReleased() {
    if (key == 'w') rotate = false;
    if (key == 'a') left = false;
    if (key == 'd') right = false;
    if (key == 's') fallFast = false;
    if (key == 'e') switchBlock = false;
    if (key == 'q') start = false;
    if (key == 'f') pause = false;
  }
