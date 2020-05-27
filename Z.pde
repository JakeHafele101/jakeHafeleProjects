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
