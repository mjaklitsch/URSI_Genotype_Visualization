#include <string>
#ifndef GENOTYPE_H_INCLUDED
#define GENOTYPE_H_INCLUDED

class Genotype {
public:
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
    float tempMovementDelay, float tempMovementDuration);
};

#endif
