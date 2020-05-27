
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
    square(x, y, heightAndWidth);
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
