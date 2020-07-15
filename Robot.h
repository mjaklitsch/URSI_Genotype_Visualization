#include "SensorArray.h"
#include "Phenotype.h" //includes "Cell.h"
#include <vector>

#ifndef ROBOT_H_INCLUDED
#define ROBOT_H_INCLUDED

// int[] toArray(ArrayList<Integer> arrayList);

void printIntegerMatrix(std::vector<std::vector<int> > integerMatrix);
void printFloatMatrix(std::vector<std::vector<float> > floatMatrix);
void printboolMatrix(std::vector<std::vector<bool> > boolMatrix);

class Robot {
public:
  SensorArray sensorArray;
  Phenotype phenotype;
  int numberOfCells;
  std::vector<Cell> cellArray;

  int numberOfNeurons;
  int numberOfPhotoSensors;
  int numberOfIRSensors;
  int numberOfRightMotors;
  int numberOfLeftMotors;

  std::vector<std::vector<float> > attachmentsBySensorIndex; // x is sensor index, y will be an array of attachments by their cell array index
  std::vector<std::vector<bool> > cellConnections;
  std::vector<std::vector<float> > cellConnectionWeights;


  Robot(SensorArray tempSensorArray, Phenotype tempPhenotype);

  void printRobot();
};

#endif
