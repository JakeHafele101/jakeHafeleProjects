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
