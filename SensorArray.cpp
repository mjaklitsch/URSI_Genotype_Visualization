#include "SensorArray.h"
#include "Phenotype.h"
#include "PolygonCalculations.h"
#include <iostream>

// double PI = 2*acos(0.0);

int numberOfSensors = 8; // 30 is the max for unknown reasons

class SensorArray {

  std::vector<SensorDot> sensorDotArray;

  SensorArray() {
    // nothing needed here yet, this class exists for organization
  }

  void recordIntersections(Phenotype phenotype) {
    int cellsInPhenotype = (phenotype->cellArray).size();
    for (int i = 0; i < cellsInPhenotype; i++) {
      if (isCellOverlappingWithPolygon(phenotype->cellArray[i])) {
        float tempTheta = phenotype->cellArray[i]->genotype->theta;
        float theta;
        if (tempTheta < 0) { // add 2 PI to get rid of negative theta
          theta = tempTheta + (2 * PI);
        } else {
          theta = tempTheta;
        }
        int sensorIndex = getIndexOfClosestSensorDotToTheta(theta);
        if (!(sensorDotArray[sensorIndex]->connections).contains(i)) {
          (sensorDotArray[sensorIndex]->connections).add(i);
        }
      }
    }
  }

  float polygonalTriangleInnerAngle = 360 / numberOfSensors;
  float polygonalTriangleOuterAngle = (180 - polygonalTriangleInnerAngle) / 2; // only used for sensors

  void initializeSensors() {
    float lastX = 0;
    float lastY = 0;
    float x = 0;
    float y = 0;
    for (float i = 0; i < 360; i += polygonalTriangleInnerAngle) {
      lastX = x;
      lastY = y;
      x = polarXAngle(i);
      y = polarYAngle(i);

      int sensorArrayIndex = int(i/polygonalTriangleInnerAngle);
      sensorDotArray[sensorArrayIndex] = new SensorDot(x, y);
    }
  }
}
