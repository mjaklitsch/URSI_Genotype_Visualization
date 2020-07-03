Genotype returnRandomNewGenotype(String cellType) {
  String type = "";
  
  if (cellType != "") {
    type = cellType;
  } else {
    int typeNumber = round(random(0, 4));
    switch(typeNumber) {
    case 0:
      type = "N";
      break;
    case 1:
      type = "P";
      break;
    case 2:
      type = "R";
      break;
    case 3:
      type = "LM";
      break;
    case 4:
      type = "RM";
      break;
    }
  }

  float theta;
  
  if (type == "LM") {
    theta = random((PI / 2), 3 * (PI / 2));
  } else if (type == "RM") {
    theta = random(-(PI / 2), (PI / 2));
    if(theta < 0){
      theta+=(2*PI);
    }
  } else {
    theta = random(0, (2*PI));
  }
  // these are defined in the main file
  int speed = int(random(minSpeed, maxSpeed));
  int movementDelay = int(random(minDelay, maxDelay));
  int movementDuration = int(random(minDuration, maxDuration));
  int growthDelay = int(random(movementDelay - 5, movementDelay + 5));
  int growthRate = int(random(minGrowthRate, maxGrowthRate));
  int growthDuration = int(random(minDuration, maxDuration));

  Genotype newGenotype = new Genotype(type, theta, growthDelay, growthRate, growthDuration, speed, movementDelay, movementDuration);
  printGenotype(newGenotype);
  return newGenotype;
}

void printGenotype(Genotype genotype) {
  println("=============================");
  print("type: " + genotype.cellType);
  println();
  if(degrees(genotype.theta) < 0){
    print("angle: " + (degrees(genotype.theta) + 360));
  } else {
    print("angle: " + degrees(genotype.theta));
  }
  println();
  print("growthDelay: " + genotype.growthDelay);
  println();
  print("growthRate: " + genotype.growthRate);
  println();
  print("growthDuration: " + genotype.growthDuration);
  println();
  print("speed: " + genotype.speed);
  println();
  print("movementDelay: " + genotype.movementDelay);
  println();
  print("movementDuration: " + genotype.movementDuration);
  println();
}
