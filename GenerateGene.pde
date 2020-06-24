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

  float angle;
  
  if (type == "LM") {
    angle = random(radians(90), radians(270));
  } else if (type == "RM") {
    angle = random(radians(-90), radians(90));
    if(angle < 0){
      angle+=(2*PI);
    }
  } else {
    angle = random(radians(0), radians(360));
  }
  // these are defined in the main file
  int speed = int(random(minSpeed, maxSpeed));
  int movementDelay = int(random(minDelay, maxDelay));
  int movementDuration = int(random(minDuration, maxDuration));
  int growthDelay = int(random(movementDelay - 5, movementDelay + 5));
  int growthRate = int(random(minGrowthRate, maxGrowthRate));
  int growthDuration = int(random(minDuration, maxDuration));

  Genotype newGenotype = new Genotype(type, angle, growthDelay, growthRate, growthDuration, speed, movementDelay, movementDuration);
  printGenotype(newGenotype);
  return newGenotype;
}

void printGenotype(Genotype genotype) {
  println();
  print("Begin Genotype");
  println();
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
  print("Done with Genotype");
  println();
}
