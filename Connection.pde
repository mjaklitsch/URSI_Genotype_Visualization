class Connection {
  float xFrom;
  float yFrom;
  float xTo;
  float yTo;
  float connectionWeight;

  Cell cellFrom;
  Cell cellTo;

  int cellFromIndex;
  int cellToIndex;

  Connection(int tempCellFromIndex, Cell tempCellFrom, int tempCellToIndex, Cell tempCellTo, float tempConnectionWeight) {
    cellFrom = tempCellFrom;
    cellTo = tempCellTo;
    
    cellFromIndex = tempCellFromIndex;
    cellToIndex = tempCellToIndex;
    
    xFrom = cellFrom.xPos;
    yFrom = cellFrom.yPos;
    xTo = cellTo.xPos;
    yTo = cellTo.yPos;
    
    connectionWeight = tempConnectionWeight;
  }
  
  void updateConnection(){
    xFrom = cellFrom.xPos;
    yFrom = cellFrom.yPos;
    xTo = cellTo.xPos;
    yTo = cellTo.yPos;
  }

  void drawConnection() {
    float[] weightPosition = getTextLabelPosition(xTo, yTo, xFrom, yFrom);
    stroke(0);
    fill(0);
    
    strokeWeight(1);
    text(connectionWeight, weightPosition[0], weightPosition[1]);
    arrow(int(xFrom), int(yFrom), int(xTo), int(yTo));
  }
}
