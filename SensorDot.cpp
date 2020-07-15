#include "SensorDot.h"
#include <iostream>

class SensorDot{

  std::vector<int> connections;

  float xPos;
  float yPos;

  SensorDot(float tempxPos, float tempyPos){
    xPos = tempxPos;
    yPos = tempyPos;
  }

}
