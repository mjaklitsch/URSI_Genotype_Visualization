class Cell {
  float checksum = random(0, 1000);

  ArrayList<Connection> downhillConnections = new ArrayList<Connection>(); // info flows from this cell to these cells
  ArrayList<Connection> uphillConnections = new ArrayList<Connection>(); // info flows from these cells to this cell
  ArrayList<Connection> neuronalConnections = new ArrayList<Connection>();

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

  Cell(String cellType) {
    genotype = returnRandomNewGenotype(cellType);
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

  boolean hasConnection(int cell1Index, int cell2Index) {
    int uplinks = uphillConnections.size();
    for (int i = 0; i < uplinks; i++) {
      if (uphillConnections.get(i).cellFromIndex == cell1Index || uphillConnections.get(i).cellFromIndex == cell2Index) {
        return true;
      }
      uplinks = uphillConnections.size();// recalculate as items will be added to list dynamically
    }
    int downlinks = downhillConnections.size();
    for (int i = 0; i < downlinks; i++) {
      if (downhillConnections.get(i).cellToIndex == cell1Index || downhillConnections.get(i).cellToIndex == cell2Index) {
        return true;
      }
      downlinks = downhillConnections.size();// recalculate as items will be added to list dynamically
    }
    int neurolinks = neuronalConnections.size(); 
    for (int i = neurolinks - 1; i >= 0; i--) { // we need to decrement here as items will be removed from this list dynamically
      if (neuronalConnections.get(i).cellToIndex == cell1Index || 
        neuronalConnections.get(i).cellToIndex == cell2Index   ||
        neuronalConnections.get(i).cellFromIndex == cell1Index || 
        neuronalConnections.get(i).cellFromIndex == cell2Index) {
        return true;
      }
    }
    return false;
  }

  void updateAllConnectionPositions() {
    int uplinks = uphillConnections.size();
    for (int i = 0; i < uplinks; i++) {
      uphillConnections.get(i).updateThisConnectionPosition();
      uplinks = uphillConnections.size(); // recalculate as items will be added to list dynamically
    }
    int neurolinks = neuronalConnections.size(); 
    for (int i = neurolinks - 1; i >= 0; i--) { // we need to decrement here as items will be removed from this list dynamically
      neuronalConnections.get(i).updateThisConnectionPosition();
    }
  }

  void drawAllConnections() {
    int uplinks = uphillConnections.size();
    for (int i = 0; i < uplinks; i++) { // uphillConnections contains all connections, downhill is only 
      // for data recording so we only need to draw one arraylist
      uphillConnections.get(i).drawThisConnection();
      uplinks = uphillConnections.size();// recalculate as items will be added to list dynamically
    }
    int neurolinks = neuronalConnections.size(); 
    for (int i = neurolinks - 1; i >= 0; i--) { // we need to decrement here as items will be removed from this list dynamically
      neuronalConnections.get(i).drawThisConnection();
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
  void spawnCell() {
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
  }
}

//class CustomCell {

//  Genotype genotype;
//  float xPos = 0;
//  float yPos = 0;
//  float diameter = 0;
//  float radius = 0;

//  float xSpeed = 0;
//  float ySpeed = 0;
//  float growthRate = 0;

//  CustomCell(Genotype tempGenotype) {
//    genotype = tempGenotype;
//  }

//  void setCellSpeedAndGrowth() {
//    if (currentTick > genotype.growthDelay) {
//      growthRate = (genotype.growthRate);
//    } 

//    if (currentTick > genotype.movementDelay) {
//      float speed = (genotype.speed);
//      xSpeed = speed * cos(genotype.theta);
//      ySpeed = speed * sin(genotype.theta);
//    }
//  }

//  void moveAndMorphCell() {
//    if (currentTick - genotype.movementDelay < genotype.movementDuration) {
//      xPos += xSpeed;
//      yPos += ySpeed;
//    }

//    if (currentTick - genotype.growthDelay < genotype.growthDuration) {
//      diameter += growthRate;
//      radius = diameter/2;
//    }
//  }

//  void spawnCell() {
//    noStroke();
//    switch(genotype.cellType) {
//    case "N":
//      fill(#c904ff);
//      break;
//    case "P":
//      fill(#f7ff00);
//      break;
//    case "R":
//      fill(#ff2600);
//      break;
//    case "LM":
//      fill(#04e600);
//      break;
//    case "RM":
//      fill(#4dff00);
//      break;
//    }

//    ellipse(xPos, yPos, radius, radius);

//    stroke(1);
//  }
//}
