final int SPEED_ACROSS = 5;
final int SPEED_DOWN = 40;
final int SPEED_ROTATE = 10;

final int STATE_START = 0;
final int STATE_PLAYING = 1;
final int STATE_PAUSE = 2;
final int STATE_OVER = 3;

Menu menu = new Menu();
Grid grid = new Grid(12, 25, 200, 40, 20, 155, 155, 155, 90, 90, 90, false);
Grid heldGrid = new Grid(4, 2, 450, 140, 20, 155, 155, 155, 90, 90, 90, true);
Grid nextGrid = new Grid(4, 2, 450, 270, 20, 155, 155, 155, 90, 90, 90, true);
Block currentBlock;
Block afterBlock = new I(grid, 4, 3);
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
  //menu = new Menu();
  //grid = new Grid(12, 25, 200, 40, 20, 155, 155, 155, 90, 90, 90, false);
  //nextGrid = new Grid(4, 2, 450, 140, 20, 155, 155, 155, 90, 90, 90, true);
  //heldGrid = new Grid(4, 2, 450, 270, 20, 155, 155, 155, 90, 90, 90, true);
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
  }
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
  switch((int)(random(7))){
    case 0:
      afterBlock = new I(nextGrid, 0, 1);
      nextBlockValue = 0;
      break;
      
    case 1:
      afterBlock = new J(nextGrid, 0, 1);
      nextBlockValue = 1;
      break;
      
    case 2:
      afterBlock = new L(nextGrid, 0, 1);
      nextBlockValue = 2;
      break;
      
    case 3:
      afterBlock = new O(nextGrid, 1, 1);
      nextBlockValue = 3;
      break;
      
    case 4:
      afterBlock = new S(nextGrid, 0, 1);
      nextBlockValue = 4;
      break;
      
    case 5:
      afterBlock = new T(nextGrid, 0, 1);
      nextBlockValue = 5;
      break;
      
    case 6:
      afterBlock = new Z(nextGrid, 1, 1);
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
  
  abstract class Block {
  
  final int RED_STROKE = 90;
  final int GREEN_STROKE = 90;
  final int BLUE_STROKE = 90;
  final int RED_FILL;
  final int GREEN_FILL;
  final int BLUE_FILL;
  
  Grid grid;
  Cell[][] map;
  
  int originIndexX;
  int originIndexY;
  
  Block(Grid grid, int RED_FILL, int GREEN_FILL, int BLUE_FILL) {
    this.grid = grid;
    this.RED_FILL = RED_FILL;
    this.GREEN_FILL = GREEN_FILL;
    this.BLUE_FILL = BLUE_FILL;
    map = grid.getMap();
  }
  
  void rotate() {
    if(map[originIndexY - 1][originIndexX - 1].canRotate && map[originIndexY - 1][originIndexX + 1].isSolid){
      return;
    }
    else if(map[originIndexY - 1][originIndexX].canRotate && map[originIndexY][originIndexX + 1].isSolid) {
      return;
    }
    else if(map[originIndexY - 1][originIndexX + 1].canRotate && map[originIndexY + 1][originIndexX + 1].isSolid) {
      return;  
    }
    else if(map[originIndexY][originIndexX - 1].canRotate && map[originIndexY - 1][originIndexX].isSolid){
      return;  
    }
    else if(map[originIndexY][originIndexX + 1].canRotate && map[originIndexY + 1][originIndexX].isSolid) {
      return;
    }
    else if(map[originIndexY + 1][originIndexX - 1].canRotate && map[originIndexY - 1][originIndexX - 1].isSolid){
      return;
    }
    else if(map[originIndexY - 1][originIndexX].canRotate && map[originIndexY][originIndexX - 1].isSolid){
      return;
    }
    
    if(map[originIndexY - 1][originIndexX - 1].canRotate && (!map[originIndexY - 1][originIndexX + 1].isSolid || map[originIndexY - 1][originIndexX + 1].canRotate)){ //Top Left
      if(map[originIndexY - 1][originIndexX - 1].stickRotate) {
        map[originIndexY - 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX - 1].stickRotateOff();
      }
      else if(map[originIndexY - 1][originIndexX + 1].canRotate){
        map[originIndexY - 1][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX + 1].stickRotateOn();
      }
      else {
        map[originIndexY - 1][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY - 1][originIndexX].canRotate && (!map[originIndexY][originIndexX + 1].isSolid || map[originIndexY][originIndexX + 1].canRotate)){ //Top Middle
      if(map[originIndexY - 1][originIndexX].stickRotate) {
        map[originIndexY - 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX - 1].stickRotateOff();
      }
      else if(map[originIndexY][originIndexX + 1].canRotate){
        map[originIndexY - 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX + 1].stickRotateOn();
      }
      else {
        map[originIndexY - 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }
    
    if(map[originIndexY - 1][originIndexX + 1].canRotate && (!map[originIndexY + 1][originIndexX + 1].isSolid || map[originIndexY + 1][originIndexX + 1].canRotate)){ //Top Right
      if(map[originIndexY - 1][originIndexX + 1].stickRotate) {
        map[originIndexY - 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX + 1].stickRotateOff();
      }
      else if(map[originIndexY + 1][originIndexX + 1].canRotate){
        map[originIndexY - 1][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX + 1].stickRotateOn();
      }
      else {
        map[originIndexY - 1][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY][originIndexX - 1].canRotate && (!map[originIndexY - 1][originIndexX].isSolid || map[originIndexY - 1][originIndexX].canRotate)){ //Middle Left
      if(map[originIndexY][originIndexX - 1].stickRotate) {
        map[originIndexY][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX - 1].stickRotateOff();
      }
      else if(map[originIndexY - 1][originIndexX].canRotate){
        map[originIndexY][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX].stickRotateOn();
      }
      else {
        map[originIndexY][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY][originIndexX + 1].canRotate && (!map[originIndexY + 1][originIndexX].isSolid || map[originIndexY + 1][originIndexX].canRotate)){ //Middle Right
      if(map[originIndexY][originIndexX + 1].stickRotate){
        map[originIndexY][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX + 1].stickRotateOff();
      }
      else if(map[originIndexY + 1][originIndexX].canRotate){
        map[originIndexY][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX].stickRotateOn();
      }
      else {
        map[originIndexY][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY + 1][originIndexX - 1].canRotate && (!map[originIndexY - 1][originIndexX - 1].isSolid || map[originIndexY - 1][originIndexX - 1].canRotate)){ //Bottom Left
      if(map[originIndexY + 1][originIndexX - 1].stickRotate){
        map[originIndexY + 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX - 1].stickRotateOff();
      }
      else if(map[originIndexY - 1][originIndexX - 1].canRotate){
        map[originIndexY + 1][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX - 1].stickRotateOn();
      }
      else {
        map[originIndexY + 1][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY + 1][originIndexX].canRotate && (!map[originIndexY][originIndexX - 1].isSolid || map[originIndexY][originIndexX - 1].canRotate)){ //Bottom Middle
      if(map[originIndexY + 1][originIndexX].stickRotate){
        map[originIndexY + 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX].stickRotateOff();
      }
      else if(map[originIndexY][originIndexX - 1].canRotate){
        map[originIndexY + 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX - 1].stickRotateOn();
      }
      else {
        map[originIndexY + 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY + 1][originIndexX + 1].canRotate && (!map[originIndexY + 1][originIndexX - 1].isSolid || map[originIndexY + 1][originIndexX - 1].canRotate)){ //Bottom Right
    
      if(map[originIndexY + 1][originIndexX + 1].stickRotate){
        map[originIndexY + 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX + 1].stickRotateOff();
      }
      else if(map[originIndexY + 1][originIndexX - 1].canRotate){
        map[originIndexY + 1][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX - 1].stickRotateOn();
      }
      else {
        map[originIndexY + 1][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    resetPlayable();
  }
  
  void resetPlayable() {
    for(int i = 4; i < map.length - 1; i++){
      for(int j = 0; j < map[0].length; j++){
        if(map[i][j].isPlaying){
          map[i][j].canRotateOn();
        }
      }
    } 
  }
  
  void fall(){
    for(int i = map.length - 2; i >= 0; i--){ 
      for(int j = map[0].length - 1; j >= 0; j--){
        if(map[i][j].isPlaying && !map[i + 1][j].isSolid){
          map[i][j].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
          map[i + 1][j].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, true);
        }
      }
    }
    originIndexY++;
  }
  
  boolean hitSolid() {
    for(int i = 4; i < map.length - 1; i++){
      for(int j = 0; j < map[0].length; j++){
        if(map[i + 1][j].isSolid && map[i][j].isPlaying){
          return true;
        }
      }
    }
    return false;
  }
  
  void moveRight() {
    for(int i = 0; i < map.length - 1; i++){
      for(int j = map[0].length - 2; j >= 1; j--){
        if(map[i][j + 1].isSolid && map[i][j].isPlaying){
          return;  
        }
      }
    }
    for(int i = 0; i < map.length - 1; i++){
      for(int j = map[0].length - 2; j >= 1; j--){
        if(map[i][j].isPlaying && !map[i][j + 1].isSolid){
          map[i][j].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
          map[i][j + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, true);
        }
      }
    }
    originIndexX++;
  }
  
  void moveLeft() {
    for(int i = 0; i < map.length - 1; i++){
      for(int j = 1; j < map[0].length - 1; j++){
        if(map[i][j - 1].isSolid && map[i][j].isPlaying){
          return;  
        }
      }
    }
    for(int i = 0; i < map.length - 1; i++){
      for(int j = 1; j < map[0].length - 1; j++){
        if(map[i][j].isPlaying && !map[i][j - 1].isSolid){
          map[i][j].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
          map[i][j - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, true);
        }
      }
    }
    originIndexX--;
  }
  
  void clearBlock(){
    for(int i = 0; i < map.length - 1; i++){
      for(int j = 1; j < map[0].length - 1; j++){
        if(map[i][j].isPlaying){
          map[i][j].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        }
      } 
    }
  }
  
}

class Cell {
  
  int x;
  int y;
  int heightAndWidth;
  int redFill;
  int greenFill;
  int blueFill;
  int redStroke;
  int greenStroke;
  int blueStroke;
  boolean isSolid;
  boolean isPlaying;
  boolean canRotate;
  boolean stickRotate;
  
  Cell(int x, int y, int heightAndWidth, int redFill, int greenFill, int blueFill, int redStroke, int greenStroke, int blueStroke, boolean isSolid, boolean isPlaying, boolean canRotate) {
    this.x = x;
    this.y = y;
    this.heightAndWidth = heightAndWidth;
    this.redFill = redFill;
    this.greenFill = greenFill;
    this.blueFill = blueFill;
    this.redStroke = redStroke;
    this.greenStroke = greenStroke;
    this.blueStroke = blueStroke;
    this.isSolid = isSolid;
    this.isPlaying = isPlaying;
    this.canRotate = canRotate;
    stickRotate = false;
  }
  
  void show() {
    fill(redFill, greenFill, blueFill);
    stroke(redStroke, greenStroke, blueStroke);
    rect(x, y, heightAndWidth, heightAndWidth);
  }
  int redFill() {
    return redFill;
  }
  
  int greenFill() {
    return greenFill;
  }
  
  int blueFill() {
    return blueFill;
  }
  
  int redStroke() {
    return redStroke;
  }
  
  int greenStroke() {
    return greenStroke;
  }
  
  int blueStroke() {
    return blueStroke;
  }
  
  boolean isSolid() {
    return isSolid;
  }
  
  boolean isPlaying() {
    return isPlaying;  
  }
  
  boolean canRotate() {
    return canRotate;  
  }

  void playingOff() {
    isPlaying = false;  
  }
  
  void solidOn() {
    isSolid = true;  
  }
  
  void canRotateOff() {
    canRotate = false;  
  }
  
  void canRotateOn() {
    canRotate = true;
  }
  
  void stickRotateOn() {
    stickRotate = true;  
  }
  
  void stickRotateOff() {
    stickRotate = false;  
  }
  
  void changeCell(int redFill, int greenFill, int blueFill, int redStroke, int blueStroke, int greenStroke, boolean isSolid, boolean isPlaying, boolean canRotate) {
    this.redFill = redFill;
    this.greenFill = greenFill;
    this.blueFill = blueFill;
    this.redStroke = redStroke;
    this.greenStroke = greenStroke;
    this.blueStroke = blueStroke;
    this.isSolid = isSolid;
    this.isPlaying = isPlaying;
    this.canRotate = canRotate;
  }
  
}

class Grid {
  
  Cell[][] map;
  int numX;
  int numY;
  int startX;
  int startY;
  int cellLength;
  int redFill;
  int greenFill;
  int blueFill;
  int redStroke;
  int greenStroke;
  int blueStroke;
  boolean hasNoSolids;

  Grid(int numX, int numY, int startX, int startY, int cellLength, int redFill, int greenFill, int blueFill, int redStroke, int greenStroke, int blueStroke, boolean hasNoSolids) {
    
    this.numX = numX;
    this.numY = numY;
    this.startX = startX;
    this.startY = startY;
    this.cellLength = cellLength;
    this.redFill = redFill;
    this.greenFill = greenFill;
    this.blueFill = blueFill;
    this.redStroke = redStroke;
    this.greenStroke = greenStroke;
    this.blueStroke = blueStroke;
    this.hasNoSolids = hasNoSolids;
    
    map = makeMap();
    
  }
  
  Cell[][] makeMap() {
    int x = startX;
    int y = startY;
    
    map = new Cell[numY][numX];
    
    if(!hasNoSolids){
      for(int i = 0; i < numY; i++){ //y iterations
        for(int j = 0; j < numX; j++){ //x iterations
          if(i <= 3) { //Spawn area
            map[i][j] = new Cell(x, y, cellLength, redStroke, greenStroke, blueStroke, redStroke, greenStroke, blueStroke, false, false, false);
          } else if(i == numY - 1) { //Hidden Solid zone at bottom
            map[i][j] = new Cell(x, y, cellLength, redStroke, greenStroke, blueStroke, redStroke, greenStroke, blueStroke, true, false, false);
          } else if(j == 0 || j == numX - 1) { //Hidden solid zone on sides
            map[i][j] = new Cell(x, y, cellLength, redStroke, greenStroke, blueStroke, redStroke, greenStroke, blueStroke, true, false, false);
          } else { //Empty Cells
            map[i][j] = new Cell(x, y, cellLength, redFill, greenFill, blueFill, redStroke, blueStroke, greenStroke, false, false, false);
          }
          x += cellLength;
        }
        y += cellLength;
        x = startX;
      }
    }
    else {
      for(int i = 0; i < numY; i++){ //y iterations
        for(int j = 0; j < numX; j++){ //x iterations
          map[i][j] = new Cell(x, y, cellLength, redFill, greenFill, blueFill, redStroke, blueStroke, greenStroke, false, false, false);
          x += cellLength;
        }
        y += cellLength;
        x = startX;
      }
    }
    return map;
  }

  
  void show() {
    if(hasNoSolids){
      for(int i = 0; i < map.length; i++){
        for(int j = 0; j < map[0].length; j++){
          map[i][j].show();
        }
      }
    }
    else {
      for(int i = 4; i < map.length; i++){ //Change to 4 so spawn area doesnt show
        for(int j = 0; j < map[0].length; j++){
          map[i][j].show();
      }
    }
    }
  }

  Cell getCell(int xIndex, int yIndex) {
    return map[yIndex][xIndex];    
  }
  
  
  void changeCell(int xIndex, int yIndex, int redFill, int greenFill, int blueFill, int redStroke, int blueStroke, int greenStroke, boolean isSolid, boolean isPlaying, boolean canRotate) {
    map[yIndex][xIndex].changeCell(redFill, greenFill, blueFill, redStroke, blueStroke, greenStroke, isSolid, isPlaying, canRotate);
  }
  
  Cell[][] getMap(){
    return map;  
  }
  
  void resetMap() {
    for(int i = 0; i < numY; i++){ //y iterations
      for(int j = 0; j < numX; j++){ //x iterations
        changeCell(j, i, redFill, greenFill, blueFill, redStroke, greenStroke, blueStroke, false, false, false);
      }
    }
  }
  
  void cleanPlaying() {
    for(int i = 0; i < map.length; i++){ //y iterations
      for(int j = 0; j < map[0].length; j++){ //x iterations
        if(map[i][j].isPlaying){
          map[i][j].solidOn();
          map[i][j].playingOff();
        }
      }
    }
  }
  
  void checkClear() {
    int solidCounter = 0;
    int linesCleared = 0;
    for(int i = 4; i < map.length - 1; i++){
      for(int j = 1; j < map[0].length - 1; j++){
        if(map[i][j].isSolid){
          solidCounter++;  
        }
      }
      if(solidCounter == 10){
          clearLine(i);
          linesCleared++;
      }
      solidCounter = 0;
    }
    menu.scoreUpLineClear(linesCleared);
  }
  
  void clearLine(int yIndex){
    for(int i = 1; i < map[0].length - 1; i++){
      changeCell(i, yIndex, redFill, greenFill, blueFill, redStroke, blueStroke, greenStroke, false, false, false);
    }

    for(int i = yIndex; i >= 5; i--){ 
      for(int j = 1; j < map[0].length - 1; j++){
        cellSwap(map[i][j], map[i - 1][j]);
      }
    }
    menu.lineChange(1);
  }
  
  boolean isGameOver(){
    
    //for(int i = 0; i < 4; i++){
      for(int j = 1; j < map[0].length - 1; j++){
        if(map[4][j].isSolid){
          return true;
        }
      //}
    }
    return false;
  }
  
  void cellSwap(Cell cell1, Cell cell2){

    int redFill1 = cell1.redFill;
    int greenFill1 = cell1.greenFill;
    int blueFill1 = cell1.blueFill;
    int redStroke1 = cell1.redStroke;
    int greenStroke1 = cell1.greenStroke;
    int blueStroke1 = cell1.blueStroke;
    boolean isSolid1 = cell1.isSolid;
    boolean isPlaying1 = cell1.isPlaying;
    boolean canRotate1 = cell1.canRotate;
    
    int redFill2 = cell2.redFill;
    int greenFill2 = cell2.greenFill;
    int blueFill2 = cell2.blueFill;
    int redStroke2 = cell2.redStroke;
    int greenStroke2 = cell2.greenStroke;
    int blueStroke2 = cell2.blueStroke;
    boolean isSolid2 = cell2.isSolid;
    boolean isPlaying2 = cell2.isPlaying;
    boolean canRotate2 = cell2.canRotate;
    
    cell1.changeCell(redFill2, greenFill2, blueFill2, redStroke2, greenStroke2, blueStroke2, isSolid2, isPlaying2, canRotate2);
    cell2.changeCell(redFill1, greenFill1, blueFill1, redStroke1, greenStroke1, blueStroke1, isSolid1, isPlaying1, canRotate1);
  }
}

class I extends Block {
  
  static final int RED_FILL = 48;
  static final int GREEN_FILL = 199;
  static final int BLUE_FILL = 239;
  
  I(Grid grid, int xIndex, int yIndex) {
    super(grid, RED_FILL, GREEN_FILL, BLUE_FILL);
    super.originIndexX = xIndex + 1;
    super.originIndexY = yIndex;
    for(int i = 0; i < 4; i++){
      grid.changeCell(xIndex, yIndex, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      xIndex++;
    }
  }
  
  void rotate() {
    if(map[originIndexY - 1][originIndexX - 1].canRotate && map[originIndexY - 1][originIndexX + 1].isSolid){
      return;
    }
    else if(map[originIndexY - 1][originIndexX].canRotate && map[originIndexY][originIndexX + 1].isSolid) {
      return;
    }
    else if(map[originIndexY - 1][originIndexX + 1].canRotate && map[originIndexY + 1][originIndexX + 1].isSolid) {
      return;  
    }
    else if(map[originIndexY][originIndexX - 1].canRotate && map[originIndexY - 1][originIndexX].isSolid){
      return;  
    }
    else if(map[originIndexY][originIndexX + 1].canRotate && map[originIndexY + 1][originIndexX].isSolid) {
      return;
    }
    else if(map[originIndexY + 1][originIndexX - 1].canRotate && map[originIndexY - 1][originIndexX - 1].isSolid){
      return;
    }
    else if(map[originIndexY - 1][originIndexX].canRotate && map[originIndexY][originIndexX - 1].isSolid){
      return;
    }
    else if(map[originIndexY + 2][originIndexX].canRotate && map[originIndexY][originIndexX + 2].isSolid){
      return;
    }
    else if(map[originIndexY][originIndexX + 2].canRotate && map[originIndexY + 2][originIndexX].isSolid){
      return;  
    }
    
    if(map[originIndexY - 1][originIndexX - 1].canRotate && (!map[originIndexY - 1][originIndexX + 1].isSolid || map[originIndexY - 1][originIndexX + 1].canRotate)){ //Top Left
      if(map[originIndexY - 1][originIndexX - 1].stickRotate) {
        map[originIndexY - 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX - 1].stickRotateOff();
      }
      else if(map[originIndexY - 1][originIndexX + 1].canRotate){
        map[originIndexY - 1][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX + 1].stickRotateOn();
      }
      else {
        map[originIndexY - 1][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY - 1][originIndexX].canRotate && (!map[originIndexY][originIndexX + 1].isSolid || map[originIndexY][originIndexX + 1].canRotate)){ //Top Middle
      if(map[originIndexY - 1][originIndexX].stickRotate) {
        map[originIndexY - 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX - 1].stickRotateOff();
      }
      else if(map[originIndexY][originIndexX + 1].canRotate){
        map[originIndexY - 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX + 1].stickRotateOn();
      }
      else {
        map[originIndexY - 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }
    
    if(map[originIndexY - 1][originIndexX + 1].canRotate && (!map[originIndexY + 1][originIndexX + 1].isSolid || map[originIndexY + 1][originIndexX + 1].canRotate)){ //Top Right
      if(map[originIndexY - 1][originIndexX + 1].stickRotate) {
        map[originIndexY - 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX + 1].stickRotateOff();
      }
      else if(map[originIndexY + 1][originIndexX + 1].canRotate){
        map[originIndexY - 1][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX + 1].stickRotateOn();
      }
      else {
        map[originIndexY - 1][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY][originIndexX - 1].canRotate && (!map[originIndexY - 1][originIndexX].isSolid || map[originIndexY - 1][originIndexX].canRotate)){ //Middle Left
    
      if(map[originIndexY][originIndexX - 1].stickRotate) {
        map[originIndexY][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX - 1].stickRotateOff();
      }
      else if(map[originIndexY - 1][originIndexX].canRotate){
        map[originIndexY][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX].stickRotateOn();
      }
      else {
        map[originIndexY][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY][originIndexX + 1].canRotate && (!map[originIndexY + 1][originIndexX].isSolid || map[originIndexY + 1][originIndexX].canRotate)){ //Middle Right
      if(map[originIndexY][originIndexX + 1].stickRotate){
        map[originIndexY][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX + 1].stickRotateOff();
      }
      else if(map[originIndexY + 1][originIndexX].canRotate){
        map[originIndexY][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX].stickRotateOn();
      }
      else {
        map[originIndexY][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY + 1][originIndexX - 1].canRotate && (!map[originIndexY - 1][originIndexX - 1].isSolid || map[originIndexY - 1][originIndexX - 1].canRotate)){ //Bottom Left
      if(map[originIndexY + 1][originIndexX - 1].stickRotate){
        map[originIndexY + 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY - 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX - 1].stickRotateOff();
      }
      else if(map[originIndexY - 1][originIndexX - 1].canRotate){
        map[originIndexY + 1][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX - 1].stickRotateOn();
      }
      else {
        map[originIndexY + 1][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY - 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY + 1][originIndexX].canRotate && (!map[originIndexY][originIndexX - 1].isSolid || map[originIndexY][originIndexX - 1].canRotate)){ //Bottom Middle
      if(map[originIndexY + 1][originIndexX].stickRotate){
        map[originIndexY + 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX].stickRotateOff();
      }
      else if(map[originIndexY][originIndexX - 1].canRotate){
        map[originIndexY + 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX - 1].stickRotateOn();
      }
      else {
        map[originIndexY + 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY + 1][originIndexX + 1].canRotate && (!map[originIndexY + 1][originIndexX - 1].isSolid || map[originIndexY + 1][originIndexX - 1].canRotate)){ //Bottom Right
      if(map[originIndexY + 1][originIndexX + 1].stickRotate){
        map[originIndexY + 1][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 1][originIndexX + 1].stickRotateOff();
      }
      else if(map[originIndexY + 1][originIndexX - 1].canRotate){
        map[originIndexY + 1][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX - 1].stickRotateOn();
      }
      else {
        map[originIndexY + 1][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 1][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }

    if(map[originIndexY + 2][originIndexX].canRotate && (!map[originIndexY][originIndexX + 2].isSolid || map[originIndexY][originIndexX + 2].canRotate)){ //Far Bottom
      if(map[originIndexY + 2][originIndexX].stickRotate){
        map[originIndexY + 2][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX + 2].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 2][originIndexX].stickRotateOff();
      }
      else if(map[originIndexY][originIndexX + 2].canRotate){
        map[originIndexY + 2][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX + 2].stickRotateOn();
      }
      else {
        map[originIndexY + 2][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY][originIndexX + 2].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }
    
    if(map[originIndexY][originIndexX + 2].canRotate && (!map[originIndexY + 2][originIndexX].isSolid || map[originIndexY + 2][originIndexX].canRotate)){ //Far Bottom
      if(map[originIndexY][originIndexX + 2].stickRotate){
        map[originIndexY][originIndexX + 2].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY + 2][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
        map[originIndexY][originIndexX + 2].stickRotateOff();
      }
      else if(map[originIndexY + 2][originIndexX].canRotate){
        map[originIndexY][originIndexX + 2].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 2][originIndexX].stickRotateOn();
      }
      else {
        map[originIndexY][originIndexX + 2].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
        map[originIndexY + 2][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      }
    }
    
  }

}

class J extends Block {
  
  static final int RED_FILL = 89;
  static final int GREEN_FILL = 101;
  static final int BLUE_FILL = 175;
  
  J(Grid grid, int xIndex, int yIndex) {
    super(grid, RED_FILL, GREEN_FILL, BLUE_FILL);
    super.originIndexX = xIndex + 1;
    super.originIndexY = yIndex;
    grid.changeCell(xIndex, yIndex - 1, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
    for(int i = 0; i < 3; i++){
      grid.changeCell(xIndex, yIndex, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      xIndex++;
    }
  }

}

class L extends Block {
  
  static final int RED_FILL = 239;
  static final int GREEN_FILL = 121;
  static final int BLUE_FILL = 34;
  
  L(Grid grid, int xIndex, int yIndex) {
    super(grid, RED_FILL, GREEN_FILL, BLUE_FILL);
    super.originIndexX = xIndex + 1;
    super.originIndexY = yIndex;
    for(int i = 0; i < 3; i++){
      grid.changeCell(xIndex, yIndex, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      if(i == 2){
        grid.changeCell(xIndex, yIndex - 1, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true);   
      }
      xIndex++;
    }
  }
  
}

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

class O extends Block {
  
  static final int RED_FILL = 247;
  static final int GREEN_FILL = 211;
  static final int BLUE_FILL = 9;
  
  O(Grid grid, int xIndex, int yIndex) {
    super(grid, RED_FILL, GREEN_FILL, BLUE_FILL);
    super.originIndexX = xIndex;
    super.originIndexY = yIndex;
    for(int i = 0; i < 2; i++){
      grid.changeCell(xIndex, yIndex, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      grid.changeCell(xIndex, yIndex - 1, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true);
      xIndex++;
    }
  }
  
  void rotate() { //Overrides so doesnt need to spin
    
  }
  
}

class S extends Block {
  
  static final int RED_FILL = 66;
  static final int GREEN_FILL = 181;
  static final int BLUE_FILL = 67;
  
  S(Grid grid, int xIndex, int yIndex) {
    super(grid, RED_FILL, GREEN_FILL, BLUE_FILL);
    super.originIndexX = xIndex + 1;
    super.originIndexY = yIndex;
    for(int i = 0; i < 2; i++){
      grid.changeCell(xIndex, yIndex, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      if(i == 1){
        grid.changeCell(xIndex, yIndex - 1, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      }
      xIndex++;
    }
    grid.changeCell(xIndex, yIndex - 1, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
  }
  
}

class T extends Block {
  
  static final int RED_FILL = 173;
  static final int GREEN_FILL = 77;
  static final int BLUE_FILL = 159;
  
  T(Grid grid, int xIndex, int yIndex) {
    super(grid, RED_FILL, GREEN_FILL, BLUE_FILL);
    super.originIndexX = xIndex + 1;
    super.originIndexY = yIndex;
    for(int i = 0; i < 3; i++){
      grid.changeCell(xIndex, yIndex, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      if(i == 1){
        grid.changeCell(xIndex, yIndex - 1, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      }
      xIndex++;
    }
  }
  
  void rotate(){
    if(!map[originIndexY - 1][originIndexX].isSolid && !map[originIndexY - 1][originIndexX].isPlaying){ //Top Middle Empty
      map[originIndexY][originIndexX + 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
      map[originIndexY - 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      map[originIndexY][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      map[originIndexY + 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
    }
    
    else if(!map[originIndexY][originIndexX - 1].isSolid && !map[originIndexY][originIndexX - 1].isPlaying){ //Middle Left Empty
      map[originIndexY - 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
      map[originIndexY][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      map[originIndexY][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      map[originIndexY + 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
    }
    
    else if(!map[originIndexY][originIndexX + 1].isSolid && !map[originIndexY][originIndexX + 1].isPlaying){ //Middle Right Empty
      map[originIndexY + 1][originIndexX].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
      map[originIndexY - 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      map[originIndexY][originIndexX - 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      map[originIndexY][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
    }
    
    else if(!map[originIndexY + 1][originIndexX].isSolid && !map[originIndexY + 1][originIndexX].isPlaying){ //Bottom Middle Empty
      map[originIndexY][originIndexX - 1].changeCell(grid.redFill, grid.greenFill, grid.blueFill, grid.redStroke, grid.greenStroke, grid.blueStroke, false, false, false);
      map[originIndexY - 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      map[originIndexY][originIndexX + 1].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
      map[originIndexY + 1][originIndexX].changeCell(RED_FILL, GREEN_FILL, BLUE_FILL, RED_STROKE, GREEN_STROKE, BLUE_STROKE, false, true, false);
    }
  }
  
}

class Z extends Block {
  
  static final int RED_FILL = 238;
  static final int GREEN_FILL = 34;
  static final int BLUE_FILL = 41;
  
  Z(Grid grid, int xIndex, int yIndex) {
    super(grid, RED_FILL, GREEN_FILL, BLUE_FILL);
    super.originIndexX = xIndex + 1;
    super.originIndexY = yIndex;
    grid.changeCell(xIndex, yIndex - 1, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
    for(int i = 0; i < 2; i++){
      grid.changeCell(xIndex + 1, yIndex, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      if(i == 0) {
        grid.changeCell(xIndex + 1, yIndex - 1, RED_FILL, GREEN_FILL, BLUE_FILL, super.RED_STROKE, super.GREEN_STROKE, super.BLUE_STROKE, false, true, true); 
      }
      xIndex++;
    }
  }
  
}
