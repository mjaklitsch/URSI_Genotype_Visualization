#include "Cell.h"
#include "Connection.h"
#include <vector>

#ifndef PHENOTYPE_H_INCLUDED
#define PHENOTYPE_H_INCLUDED

class Phenotype {
public:
  std::vector<Cell> cellArray;
  std::vector<Connection> connectionVector;
  int numberOfCells;

  // float partCost; // later implementation

  Phenotype(int minNeurons, int maxNeurons, int minPhotoSensors,
    int maxPhotoSensors, int minIRSensors, int maxIRSensors,
    int minLeftMotors, int maxLeftMotors, int minRightMotors,
    int maxRightMotors);

  void addConnection(int i, int j);
  void moveCells();
  void recordIntersections();
  void updateAllConnectionPositions();
  bool hasSpecificDirectionalConnection(int cellFromIndex, int cellToIndex);
  bool hasConnection(int cell1Index, int cell2Index);
  float getSpecificDirectionalConnectionWeight(int cellFromIndex, int cellToIndex);

};

#endif
