class Phenotype {

  Cell[] cellArray;
  int numberOfCells;

  Phenotype(int tempNumberOfCells, int neurons, int photoSensors, int irSensors, int leftMotors, int rightMotors) {
    int specifiedCellSum = (neurons + photoSensors + irSensors + leftMotors + rightMotors);
    numberOfCells = tempNumberOfCells;

    if (tempNumberOfCells < specifiedCellSum) {
      numberOfCells = specifiedCellSum;
      print("The Phenotype class always builds specified cells even if it exceeds the specified cell limit, as a result " + 
        specifiedCellSum + " cells were added instead of the desired " + tempNumberOfCells);
      println();
    } else if (tempNumberOfCells > specifiedCellSum && !(specifiedCellSum <= 0)) {
      print("The Phenotype class always builds up to the specified cell limit, as a result " + 
        (tempNumberOfCells - specifiedCellSum)  + " cells were added in addition to your specified " + specifiedCellSum);
      println();
    }

    cellArray = new Cell[numberOfCells];

    int arrayIndex = 0;

    for (int i = arrayIndex; i < neurons + arrayIndex; i++) { 
      Cell nextCell = new Cell("N");
      cellArray[i] = nextCell;
    }
    arrayIndex += neurons;

    for (int i = arrayIndex; i < photoSensors + arrayIndex; i++) { 
      Cell nextCell = new Cell("P");
      cellArray[i] = nextCell;
    }
    arrayIndex += photoSensors;

    for (int i = arrayIndex; i < irSensors + arrayIndex; i++) { 
      Cell nextCell = new Cell("R");
      cellArray[i] = nextCell;
    }
    arrayIndex += irSensors;

    for (int i = arrayIndex; i < leftMotors + arrayIndex; i++) { 
      Cell nextCell = new Cell("LM");
      cellArray[i] = nextCell;
    }
    arrayIndex += leftMotors;

    for (int i = arrayIndex; i < rightMotors + arrayIndex; i++) { 
      Cell nextCell = new Cell("RM");
      cellArray[i] = nextCell;
    }
    arrayIndex += rightMotors;

    for (int i = arrayIndex; i < numberOfCells; i++) {
      Cell nextCell = new Cell("");
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

  void drawConnections() {
    for (int i = 0; i < numberOfCells; i++) {
      int uplinks = cellArray[i].uphillLinks.size();
      for (int j = 0; j < uplinks; j++) {
        Cell theCellBeingLinkedTo = cellArray[cellArray[i].uphillLinks.get(j)];

        float xPos1 = cellArray[i].xPos;
        float yPos1 = cellArray[i].yPos;
        float xPos2 = theCellBeingLinkedTo.xPos;
        float yPos2 = theCellBeingLinkedTo.yPos;

        arrow(int(xPos2), int(yPos2), int(xPos1), int(yPos1));
      }
    }
  }

  void recordIntersections() {
    for (int i = 0; i < numberOfCells; i++) {
      for (int j = i+1; j < numberOfCells; j++) {
        if (!cellArray[i].downhillLinks.contains(j) && !cellArray[i].uphillLinks.contains(j)) {
          if (((cellArray[i].radius + cellArray[j].radius) > 
            distanceBetween(cellArray[i].xPos, cellArray[i].yPos, 
            cellArray[j].xPos, cellArray[j].yPos)) && 
            (cellArray[i].diameter > 0) && 
            (cellArray[j].diameter > 0)) {
            if (cellArray[i].diameter > cellArray[j].diameter) { // info flows from i to j
              if ((cellArray[j].genotype.cellType != "R") && (cellArray[j].genotype.cellType != "P")) { // information cannot flow to sensors
                cellArray[i].downhillLinks.add(j);
                cellArray[j].uphillLinks.add(i);
              }
            } else if (cellArray[i].diameter < cellArray[j].diameter) { // info flows from j to i
              if ((cellArray[i].genotype.cellType != "R") && (cellArray[i].genotype.cellType != "P")) { // information cannot flow to sensors
                cellArray[j].downhillLinks.add(i);
                cellArray[i].uphillLinks.add(j);
              }
            }
          }
        }
      }
    }
  }
}
