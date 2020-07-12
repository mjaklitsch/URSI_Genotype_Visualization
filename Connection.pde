class Connection {

  float checksum = random(0, 1000); // even if this is only to 2 decimal places it has a 1/100000 chance of a repeat

  float x1;
  float y1;
  float x2;
  float y2;
  float connectionWeight;

  Cell cell1;
  Cell cell2;

  float xFrom;
  float yFrom;
  float xTo;
  float yTo;

  Cell cellFrom; // use this to figure out if a swap happened
  Cell cellTo;

  int cellFromIndex;
  int cellToIndex;

  boolean hasUncheckedNeuronalConnection = false;
  boolean connectionIsComplete = false;

  Connection(int tempCellFromIndex, int tempCellToIndex, Cell tempCell1, Cell tempCell2) {

    cellFromIndex = tempCellFromIndex;
    cellToIndex = tempCellToIndex;

    cell1 = tempCell1;
    cell2 = tempCell2;

    x1 = cell1.xPos;
    y1 = cell1.yPos;
    x2 = cell2.xPos;
    y2 = cell2.yPos;
  }

  //void swapConnectionToFrom() {
  //  Cell tempCellFrom = cellFrom;
  //  cellFrom = cellTo;
  //  cellTo = tempCellFrom;
  //}

  void updateThisConnectionPosition() {

    if (!connectionIsComplete) {
      x1 = cell1.xPos;
      y1 = cell1.yPos;
      x2 = cell2.xPos;
      y2 = cell2.yPos;
      if ((cell1.doneGrowing == true && cell1.doneMoving == true) && // if both cells...
        (cell2.doneGrowing == true && cell2.doneMoving == true)) { // ...are done moving/growing
        setCellToAndCellFrom();
        connectionWeight = calculateConnectionWeight(cellFrom, cellTo);
        connectionIsComplete = true;
      }
    }
  }

  void setCellToAndCellFrom() {
    if (cell1.isSensor()) {
      cellTo = cell2;
      cellFrom = cell1;
      cellFromIndex = cellFrom.index;
      cellToIndex = cellTo.index;
      xTo = cellTo.xPos;
      yTo = cellTo.yPos;
      xFrom = cellFrom.xPos;
      yFrom = cellFrom.yPos;
    } else if (cell1.isMotor()) {
      cellTo = cell1;
      cellFrom = cell2;
      cellFromIndex = cellFrom.index;
      cellToIndex = cellTo.index;
      xTo = cellTo.xPos;
      yTo = cellTo.yPos;
      xFrom = cellFrom.xPos;
      yFrom = cellFrom.yPos;
    } else if (cell1.isNeuron()) { 
      if (cell2.isSensor()) {
        cellTo = cell1;
        cellFrom = cell2;
        cellFromIndex = cellFrom.index;
        cellToIndex = cellTo.index;
        xTo = cellTo.xPos;
        yTo = cellTo.yPos;
        xFrom = cellFrom.xPos;
        yFrom = cellFrom.yPos;
      } else if (cell2.isMotor()) {
        cellTo = cell2;
        cellFrom = cell1;
        cellFromIndex = cellFrom.index;
        cellToIndex = cellTo.index;
        xTo = cellTo.xPos;
        yTo = cellTo.yPos;
        xFrom = cellFrom.xPos;
        yFrom = cellFrom.yPos;
      } else if (cell2.isNeuron()) { 
        if (cell1.diameter > cell2.diameter) {
          cellTo = cell2;
          cellFrom = cell1;
          cellFromIndex = cellFrom.index;
          cellToIndex = cellTo.index;
          xTo = cellTo.xPos;
          yTo = cellTo.yPos;
          xFrom = cellFrom.xPos;
          yFrom = cellFrom.yPos;
        } else if (cell1.diameter <= cell2.diameter) {
          cellTo = cell1;
          cellFrom = cell2;
          cellFromIndex = cellFrom.index;
          cellToIndex = cellTo.index;
          xTo = cellTo.xPos;
          yTo = cellTo.yPos;
          xFrom = cellFrom.xPos;
          yFrom = cellFrom.yPos;
        }
      }
    }
  }

  boolean isConnectionFromFirstToSecond(int first, int second) {
    if (cellFromIndex == first && cellToIndex == second) {
      return true;
    } else {
      return false;
    }
  }

  void drawThisConnection() {
    if (connectionIsComplete) {
      float[] weightPosition = getTextLabelPosition(xFrom, yFrom, xTo, yTo);
      stroke(0);
      fill(0);

      strokeWeight(1);
      text(connectionWeight, weightPosition[0], weightPosition[1]);
      arrow(int(xFrom), int(yFrom), int(xTo), int(yTo));
    } else {
      float[] weightPosition = getTextLabelPosition(x2, y2, x1, y1);
      stroke(0);
      fill(0);

      strokeWeight(1);
      text("Calculating...", weightPosition[0], weightPosition[1]);
      line(x1, y1, x2, y2);
    }
  }
}
