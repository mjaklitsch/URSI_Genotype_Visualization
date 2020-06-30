class Cell {

  ArrayList<Connection> downhillConnections = new ArrayList<Connection>(); // info flows from this cell to these cells
  ArrayList<Connection> uphillConnections = new ArrayList<Connection>(); // info flows from these cells to this cell

  Genotype genotype;
  float xPos = 0;
  float yPos = 0;
  float diameter = 0;
  float radius = 0;

  float xSpeed = 0;
  float ySpeed = 0;
  float growthRate = 0;

  Cell(String cellType) {
    genotype = returnRandomNewGenotype(cellType);
  }

  boolean hasConnection(int cell1Index, int cell2Index) {
    int uplinks = uphillConnections.size();
    for (int i = 0; i < uplinks; i++) {
      if (uphillConnections.get(i).cellFromIndex == cell1Index || uphillConnections.get(i).cellFromIndex == cell2Index) {
        return true;
      }
    }
    int downlinks = downhillConnections.size();
    for (int i = 0; i < downlinks; i++) {
      if (downhillConnections.get(i).cellToIndex == cell1Index || downhillConnections.get(i).cellToIndex == cell2Index) {
        return true;
      }
    }
    return false;
  }

  void updateConnections() {
    int uplinks = uphillConnections.size();
    for (int i = 0; i < uplinks; i++) {
      uphillConnections.get(i).updateConnection();
    }
  }

  void drawConnections() {
    int uplinks = uphillConnections.size();
    for (int i = 0; i < uplinks; i++) {
      uphillConnections.get(i).drawConnection();
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
    if (currentTick - genotype.movementDelay < genotype.movementDuration) {
      xPos += xSpeed;
      yPos -= ySpeed;
    }

    if (currentTick - genotype.growthDelay < genotype.growthDuration) {
      diameter += growthRate;
      radius = diameter/2;
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
