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
