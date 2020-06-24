class Cell {
  
  ArrayList<Integer> downhillLinks = new ArrayList<Integer>(); // info flows from this cell to these cells
  ArrayList<Integer> uphillLinks = new ArrayList<Integer>(); // info flows from these cells to this cell
  
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
