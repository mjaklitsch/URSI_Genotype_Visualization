class Phenotype {

  Cell[] cellArray;
  int numberOfCells;

  Phenotype(int tempNumberOfCells) {
    numberOfCells = tempNumberOfCells;
    cellArray = new Cell[numberOfCells];
    for (int i = 0; i < numberOfCells; i++) {
      Cell nextCell = new Cell();
      cellArray[i] = nextCell;
    }
  }

  void drawPhenotype() {
    for (int i = 0; i < numberOfCells; i ++) {
      cellArray[i].moveAndMorphCell();
      cellArray[i].setCellSpeedAndGrowth();
      cellArray[i].spawnCell();
    }
  }
  
  void drawConnections(){
    for(int i = 0; i < numberOfCells; i++){
      int uplinks = cellArray[i].uphillLinks.size();
      for(int j = 0; j < uplinks; j++){
        Cell linkTo = cellArray[cellArray[i].uphillLinks.get(j)];
        
        float xPos1 = cellArray[i].xPos;
        float yPos1 = cellArray[i].yPos;
        float xPos2 = linkTo.xPos;
        float yPos2 = linkTo.yPos;
        arrow(int(xPos2), int(yPos2), int(xPos1), int(yPos1));
      }
    }
  }

  void recordIntersections() {
    for (int i = 0; i < numberOfCells; i++) {
      for (int j = i+1; j < numberOfCells; j++) {
        if (!cellArray[i].downhillLinks.contains(j) && !cellArray[i].uphillLinks.contains(j)) {
          if (((cellArray[i].diameter/2 + cellArray[j].diameter/2) > 
            distanceBetween(cellArray[i].xPos, cellArray[i].yPos, 
            cellArray[j].xPos, cellArray[j].yPos)) && 
            (cellArray[i].diameter > 0) && 
            (cellArray[j].diameter > 0)) {
            if (cellArray[i].diameter > cellArray[j].diameter) {
              cellArray[i].downhillLinks.add(j);
              cellArray[j].uphillLinks.add(i);
            } else if (cellArray[i].diameter < cellArray[j].diameter) {
              cellArray[j].downhillLinks.add(i);
              cellArray[i].uphillLinks.add(j);
            }
          }
        }
      }
    }
  }
}

void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}
