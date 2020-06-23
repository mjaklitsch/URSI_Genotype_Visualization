class Genotype {
  String type;
  float angle;
  float growthDelay;
  float growthRate;
  float growthDuration;
  float speed;
  float movementDelay;
  float movementDuration;

  Genotype(String tempType, float tempAngle, float tempGrowthDelay, 
    float tempGrowthRate, float tempGrowthDuration, float tempSpeed, 
    float tempMovementDelay, float tempMovementDuration) {

    type = tempType;
    angle = tempAngle;
    growthDelay = tempGrowthDelay;
    growthRate = tempGrowthRate;
    growthDuration = tempGrowthDuration;
    speed = tempSpeed;
    movementDelay = tempMovementDelay;
    movementDuration = tempMovementDuration;
  }
}
