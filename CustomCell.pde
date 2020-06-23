class CustomCell {

  Genotype genotype;
  float xPos = 0;
  float yPos = 0;
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
    noStroke();
    switch(genotype.type) {
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
