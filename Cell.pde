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

  void spawnCell() {
    switch(genotype.type) {
    case "N":
      fill(#c904ff, 70);
      break;
    case "P":
      fill(#f7ff00, 70);
      break;
    case "R":
      fill(#ff2600, 70);
      break;
    case "LM":
      fill(#04e600, 70);
      break;
    case "RM":
      fill(#4dff00, 70);
      break;
    }
    ellipse(xPos, yPos, radius, radius);

  }
}
