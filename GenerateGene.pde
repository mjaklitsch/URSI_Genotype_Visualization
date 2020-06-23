int minDelay;
int maxDelay;
int minSpeed;
int maxSpeed;
int minGrowthRate;
int maxGrowthRate;
int minDuration;
int maxDuration;

Genotype returnRandomNewGenotype() {
  String type = "N";
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
 
  minDuration = 20;
  maxDuration = 40;
  minDelay = 0;
  maxDelay = ticks - maxDuration;
  minSpeed = 6;
  maxSpeed = 12;
  minGrowthRate = 3;
  maxGrowthRate = 7;
  int angle;
  if(type == "LM"){
    angle = int(random(180, 360));
  } else if(type == "RM"){
    angle = int(random(0, 180));
  } else {
    angle = int(random(0, 360));
  }
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

void printGenotype(Genotype genotype){
  println();
  print("Begin Genotype");
  println();
  print("type: " + genotype.type);
  println();
  print("angle: " + genotype.angle);
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
