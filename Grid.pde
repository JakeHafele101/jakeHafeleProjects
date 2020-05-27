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
  } //<>//
  
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
