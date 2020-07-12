class Cell {
  int index;

  //ArrayList<Connection> downhillConnections = new ArrayList<Connection>(); // info flows from this cell to these cells
  //ArrayList<Connection> uphillConnections = new ArrayList<Connection>(); // info flows from these cells to this cell
  //ArrayList<Connection> neuronalConnections = new ArrayList<Connection>();

  ArrayList<Connection> cellConnections = new ArrayList<Connection>();

  Genotype genotype;
  float xPos = 0;
  float yPos = 0;
  float diameter = 0;
  float radius = 0;

  float xSpeed = 0;
  float ySpeed = 0;
  float growthRate = 0;

  boolean doneMoving = false;
  boolean doneGrowing = false;

  Cell(String cellType, int tempIndex) {
    genotype = returnRandomNewGenotype(cellType);
    index = tempIndex;
  }

  boolean isMotor() {
    if (genotype.cellType == "LM" || genotype.cellType == "RM") {
      return true;
    } else {
      return false;
    }
  }

  boolean isSensor() {
    if (genotype.cellType == "R" || genotype.cellType == "P") {
      return true;
    } else {
      return false;
    }
  }

  boolean isNeuron() {
    if (genotype.cellType == "N") {
      return true;
    } else {
      return false;
    }
  }

  boolean hasSpecificDirectionalConnection(int cellFromIndex, int cellToIndex) {
    int links = cellConnections.size();
    for (int i = 0; i < links; i++) {
      if (cellConnections.get(i).isConnectionFromFirstToSecond(cellFromIndex, cellToIndex)) {
        //then there is a connection and we return true
        return true;
      }
    }
    // else return false as no connection exists yet
    return false;
  }

  boolean hasConnection(int cell1Index, int cell2Index) {
    int links = cellConnections.size();
    for (int i = 0; i < links; i++) {
      if ((cellConnections.get(i).isConnectionFromFirstToSecond(cell1Index, cell2Index)) || // if from cell1 to cell2
        (cellConnections.get(i).isConnectionFromFirstToSecond(cell2Index, cell1Index))) {// or if from cell2 to cell1
        //then there is a connection and we return true
        return true;
      }
      //links = cellConnections.size();// recalculate as items will be added to list dynamically (should be unnecessary now)
    }
    // else return false as no connection exists yet
    return false;
  }

  float getSpecificDirectionalConnectionWeight(int cellFromIndex, int cellToIndex) {
    int links = cellConnections.size();
    for (int i = 0; i < links; i++) {
      if (cellConnections.get(i).isConnectionFromFirstToSecond(cellFromIndex, cellToIndex)) {
        return cellConnections.get(i).connectionWeight;
      }
    }
    print("This should never print");
    return 0;
  }

  void updateAllConnectionPositions() {
    int links = cellConnections.size();
    for (int i = 0; i < links; i++) {
      cellConnections.get(i).updateThisConnectionPosition();
      //links = cellConnections.size(); // recalculate as items will be added to list dynamically (should be unnecessary now)
    }
  }

  void drawAllConnections() {
    int links = cellConnections.size();
    for (int i = 0; i < links; i++) { 
      cellConnections.get(i).drawThisConnection();
      //uplinks = uphillConnections.size();// recalculate as items will be added to list dynamically (should be unnecessary now)
    }
  }

  void setCellSpeedAndGrowth() {
    if (currentTick > genotype.growthDelay) {
      growthRate = (genotype.growthRate / actionSpread);
    } 

    if (currentTick > genotype.movementDelay) {
      float speed = (genotype.speed / actionSpread);
      xSpeed = speed * cos(genotype.theta);
      ySpeed = speed * sin(genotype.theta);
    }
  }

  void moveAndMorphCell() {
    if (!doneMoving && (currentTick - genotype.movementDelay < genotype.movementDuration)) {
      xPos += xSpeed;
      yPos -= ySpeed;
    } else {
      doneMoving = true;
    }

    if (!doneGrowing && (currentTick - genotype.growthDelay < genotype.growthDuration)) {
      diameter += growthRate;
      radius = diameter/2;
    } else {
      doneGrowing = true;
    }
  }

  int opacity = 85;
  void drawCell() {
    switch(genotype.cellType) {
    case "N":
      fill(#c904ff, opacity);
      break;
    case "P":
      fill(#f7ff00, opacity);
      break;
    case "R":
      fill(#ff2600, opacity);
      break;
    case "LM":
      fill(#04e600, opacity);
      break;
    case "RM":
      fill(#4dff00, opacity);
      break;
    }

    ellipse(xPos, yPos, diameter, diameter);
    fill(0);
    if (diameter > 0 && showIndexes == true) {
      text(index, xPos, yPos);
    }
  }

  void printGenes() {
    printGenotype(genotype);
  }

  //==================================
  // Deprecated functions 
  //==================================
  //boolean hasConnection(int cell1Index, int cell2Index) {
  //  int uplinks = uphillConnections.size();
  //  for (int i = 0; i < uplinks; i++) {
  //    if (uphillConnections.get(i).cellFromIndex == cell1Index || uphillConnections.get(i).cellFromIndex == cell2Index) {
  //      return true;
  //    }
  //    uplinks = uphillConnections.size();// recalculate as items will be added to list dynamically
  //  }
  //  int downlinks = downhillConnections.size();
  //  for (int i = 0; i < downlinks; i++) {
  //    if (downhillConnections.get(i).cellToIndex == cell1Index || downhillConnections.get(i).cellToIndex == cell2Index) {
  //      return true;
  //    }
  //    downlinks = downhillConnections.size();// recalculate as items will be added to list dynamically
  //  }
  //  int neurolinks = neuronalConnections.size(); 
  //  for (int i = neurolinks - 1; i >= 0; i--) { // we need to decrement here as items will be removed from this list dynamically
  //    if (neuronalConnections.get(i).cellToIndex == cell1Index || 
  //      neuronalConnections.get(i).cellToIndex == cell2Index   ||
  //      neuronalConnections.get(i).cellFromIndex == cell1Index || 
  //      neuronalConnections.get(i).cellFromIndex == cell2Index) {
  //      return true;
  //    }
  //  }
  //  return false;
  //}

  //void updateAllConnectionPositions() {
  //  int uplinks = uphillConnections.size();
  //  for (int i = 0; i < uplinks; i++) {
  //    uphillConnections.get(i).updateThisConnectionPosition();
  //    uplinks = uphillConnections.size(); // recalculate as items will be added to list dynamically
  //  }
  //  int neurolinks = neuronalConnections.size(); 
  //  for (int i = neurolinks - 1; i >= 0; i--) { // we need to decrement here as items will be removed from this list dynamically
  //    neuronalConnections.get(i).updateThisConnectionPosition();
  //  }
  //}

  //void drawAllConnections() {
  //  int uplinks = uphillConnections.size();
  //  for (int i = 0; i < uplinks; i++) { // uphillConnections contains all connections, downhill is only 
  //    // for data recording so we only need to draw one arraylist
  //    uphillConnections.get(i).drawThisConnection();
  //    uplinks = uphillConnections.size();// recalculate as items will be added to list dynamically
  //  }
  //  int neurolinks = neuronalConnections.size(); 
  //  for (int i = neurolinks - 1; i >= 0; i--) { // we need to decrement here as items will be removed from this list dynamically
  //    neuronalConnections.get(i).drawThisConnection();
  //  }
  //}
}
