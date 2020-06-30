class Phenotype {

  Cell[] cellArray;
  int numberOfCells;

  float partCost; // later implementation

  Phenotype(int minNeurons, int maxNeurons, int minPhotoSensors, int maxPhotoSensors, 
    int minIRSensors, int maxIRSensors, int minLeftMotors, int maxLeftMotors, int minRightMotors, int maxRightMotors) {

    int neurons = int(random(minNeurons, maxNeurons));
    int photoSensors = int(random(minPhotoSensors, maxPhotoSensors));
    int irSensors = int(random(minIRSensors, maxIRSensors));
    int leftMotors = int(random(minLeftMotors, maxLeftMotors));
    int rightMotors = int(random(minRightMotors, maxRightMotors));

    numberOfCells = neurons + photoSensors + irSensors + leftMotors + rightMotors;

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
      cellArray[i].updateConnections();
      cellArray[i].drawConnections();
    }
  }

  void recordIntersections() {
    for (int i = 0; i < numberOfCells; i++) {
      for (int j = i+1; j < numberOfCells; j++) {

        Cell celli = cellArray[i];
        Cell cellj = cellArray[j];

        float ixPos = celli.xPos;
        float iyPos = celli.yPos;
        float jxPos = cellj.xPos;
        float jyPos = cellj.yPos;


        // constant variables added for ease of readability

        if (!celli.hasConnection(i, j)) { // if no connection has been recorded yet
          if (((celli.radius + cellj.radius) > distanceBetween(ixPos, iyPos, jxPos, jyPos)) && 
            (celli.diameter > 0) && 
            (cellj.diameter > 0)) { // if the two have spawned and are overlapping
            if (celli.diameter > cellj.diameter) { // if i is bigger than j, info flows from i to j
              if ((cellj.genotype.cellType != "R") && (cellj.genotype.cellType != "P")) { // information cannot flow to sensors
                float connectionWeight = calculateConnectionWeight(celli, cellj);
                Connection newConnection = new Connection(i, celli, j, cellj, connectionWeight);
                celli.downhillConnections.add(newConnection);
                cellj.uphillConnections.add(newConnection);
              }
            } else if (celli.diameter < cellArray[j].diameter) { // if j is bigger than i,  info flows from j to i
              if ((celli.genotype.cellType != "R") && (celli.genotype.cellType != "P")) { // information cannot flow to sensors
                float connectionWeight = calculateConnectionWeight(cellj, celli);
                Connection newConnection = new Connection(j, cellj, i, celli, connectionWeight);
                cellj.downhillConnections.add(newConnection);
                celli.uphillConnections.add(newConnection);
              }
            }
          }
        }
      }
    }
  }
}
