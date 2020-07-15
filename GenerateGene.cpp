#include "GenerateGene.h"
#include "random.h"
#include "PolygonCalculations.h"
#include <iostream>

// double PI = 2*acos(0.0);
// Genotype Generation Variables
int minDuration = 20;
int maxDuration = 40;
int minDelay = 0;
//int maxDelay = 0; // for testing
int maxDelay = ticks - maxDuration;
int minSpeed = 4;
int maxSpeed = 12;
int minGrowthRate = 3;
int maxGrowthRate = 7;

Genotype returnRandomNewGenotype(string cellType) {
  string type = "";
  srand((unsigned) time(0));

  if (cellType != "") {
    type = cellType;
  } else {
    int typeNumber = intRandom(0,4);
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
    theta = floatRandom((PI / 2), (3 * (PI / 2)));
  } else if (type == "RM") {
    theta = floatRandom(-(PI / 2), (PI / 2));
    if(theta < 0){
      theta+=(2*PI);
    }
  } else {
    theta = floatRandom(0, (2*PI));
  }
  // these are defined in the main file
  int speed = intRandom(minSpeed, maxSpeed);
  int movementDelay = intRandom(minDelay, maxDelay);
  int movementDuration = intRandom(minDuration, maxDuration);
  int growthDelay = intRandom(movementDelay - 5, movementDelay + 5);
  int growthRate = intRandom(minGrowthRate, maxGrowthRate);
  int growthDuration = intRandom(minDuration, maxDuration);

  Genotype newGenotype = new Genotype(type, theta, growthDelay, growthRate, growthDuration, speed, movementDelay, movementDuration);
  printGenotype(newGenotype);
  return newGenotype;
}

void printGenotype(Genotype genotype) {
  println("=============================");
  print("type: " + genotype->cellType);
  println();
  if(degrees(genotype->theta) < 0){
    print("angle: " + (degrees(genotype->theta) + 360));
  } else {
    print("angle: " + degrees(genotype->theta));
  }
  println();
  print("growthDelay: " + genotype->growthDelay);
  println();
  print("growthRate: " + genotype->growthRate);
  println();
  print("growthDuration: " + genotype->growthDuration);
  println();
  print("speed: " + genotype->speed);
  println();
  print("movementDelay: " + genotype->movementDelay);
  println();
  print("movementDuration: " + genotype->movementDuration);
  println();
}
