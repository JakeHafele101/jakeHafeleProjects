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
    if(map[originIndexY - 1][originIndexX - 1].canRotate && map[originIndexY - 1][originIndexX + 1].isSolid){ //<>//
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
        if(map[i + 1][j].isSolid && map[i][j].isPlaying()){
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
