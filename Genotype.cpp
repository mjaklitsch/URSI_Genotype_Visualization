#include "Genotype.h"
#include <iostream>

class Genotype {
  string cellType;
  float theta;
  float growthDelay;
  float growthRate;
  float growthDuration;
  float speed;
  float movementDelay;
  float movementDuration;

  Genotype(string tempCellType, float tempTheta, float tempGrowthDelay,
    float tempGrowthRate, float tempGrowthDuration, float tempSpeed,
    float tempMovementDelay, float tempMovementDuration) {

    cellType = tempCellType;
    theta = tempTheta;
    growthDelay = tempGrowthDelay;
    growthRate = tempGrowthRate;
    growthDuration = tempGrowthDuration;
    speed = tempSpeed;
    movementDelay = tempMovementDelay;
    movementDuration = tempMovementDuration;
  }
}
