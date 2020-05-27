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
