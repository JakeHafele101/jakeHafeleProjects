class J extends Block {
  
  static final int RED_FILL = 89;
  static final int GREEN_FILL = 101;
  static final int BLUE_FILL = 175;
  
  J(Grid grid, int xIndex, int yIndex) { //<>//
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
