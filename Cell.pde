class Cell {

  Genotype genotype;
  float xPos = 0;
  float yPos = 0;
  float radius = 0;

  float xSpeed = 0;
  float ySpeed = 0;
  float growthRate = 0;

  Cell() {
    genotype = returnRandomNewGenotype();
  }

  void setCellSpeedAndGrowth() {
    if (currentTick > genotype.growthDelay) {
      growthRate = (genotype.growthRate / actionSpread);
    } 

    if (currentTick > genotype.movementDelay) {
      float speed = (genotype.speed / actionSpread);
      xSpeed = speed * sin(genotype.angle);
      ySpeed = speed * cos(genotype.angle);
    }
  }

  void moveAndMorphCell() {
    if (currentTick - genotype.movementDelay < genotype.movementDuration) {
      xPos += xSpeed;
      yPos += ySpeed;
    }



    if (currentTick - genotype.growthDelay < genotype.growthDuration) {
      radius += growthRate;
    }
  }
 int opacity = 85;
  void spawnCell() {
    switch(genotype.type) {
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
    ellipse(xPos, yPos, radius, radius);

  }
}
