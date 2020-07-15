#include "SensorDot.h"
#include "Phenotype.h"
#include <vector>

#ifndef SENSORARRAY_H_INCLUDED
#define SENSORARRAY_H_INCLUDED

int numberOfSensors;

class SensorArray {
public:
  std::vector<SensorDot> sensorDotArray;

  SensorArray();

  void recordIntersections(Phenotype phenotype);

  float polygonalTriangleInnerAngle;
  float polygonalTriangleOuterAngle; // only used for sensors

  void initializeSensors();
};

#endif
