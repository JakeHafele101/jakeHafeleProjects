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
