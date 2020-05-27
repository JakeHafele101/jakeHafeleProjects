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
