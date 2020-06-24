class CustomCell {

  Genotype genotype;
  float xPos = 0;
  float yPos = 0;
  float diameter = 0;
  float radius = 0;

  float xSpeed = 0;
  float ySpeed = 0;
  float growthRate = 0;

  CustomCell(Genotype tempGenotype) {
    genotype = tempGenotype;
  }

  void setCellSpeedAndGrowth() {
    if (currentTick > genotype.growthDelay) {
      growthRate = (genotype.growthRate);
    } 

    if (currentTick > genotype.movementDelay) {
      float speed = (genotype.speed);
      xSpeed = speed * cos(genotype.theta);
      ySpeed = speed * sin(genotype.theta);
    }
  }

  void moveAndMorphCell() {
    if (currentTick - genotype.movementDelay < genotype.movementDuration) {
      xPos += xSpeed;
      yPos += ySpeed;
    }

    if (currentTick - genotype.growthDelay < genotype.growthDuration) {
      diameter += growthRate;
      radius = diameter/2;
    }
  }

  void spawnCell() {
    noStroke();
    switch(genotype.cellType) {
    case "N":
      fill(#c904ff);
      break;
    case "P":
      fill(#f7ff00);
      break;
    case "R":
      fill(#ff2600);
      break;
    case "LM":
      fill(#04e600);
      break;
    case "RM":
      fill(#4dff00);
      break;
    }

    ellipse(xPos, yPos, radius, radius);

    stroke(1);
  }
}
