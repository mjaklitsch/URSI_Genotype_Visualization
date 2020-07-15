#include "Phenotype.h"
#include "random.h"
#include "PolygonCalculations.h"
#include <iostream>

class Phenotype {

  std::vector<Cell> cellArray;
  std::vector<Connection> connectionVector;//turn into vector
  int numberOfCells = 0;

  // float partCost; // later implementation

  Phenotype(int minNeurons, int maxNeurons, int minPhotoSensors,
    int maxPhotoSensors, int minIRSensors, int maxIRSensors,
    int minLeftMotors, int maxLeftMotors, int minRightMotors,
    int maxRightMotors) {

    int neurons = intRandom(minNeurons, maxNeurons);
    int photoSensors = intRandom(minPhotoSensors, maxPhotoSensors);
    int irSensors = intRandom(minIRSensors, maxIRSensors);
    int leftMotors = intRandom(minLeftMotors, maxLeftMotors);
    int rightMotors = intRandom(minRightMotors, maxRightMotors);

    numberOfCells = neurons + photoSensors + irSensors + leftMotors + rightMotors;

    int arrayIndex = 0;

    for (int i = arrayIndex; i < neurons + arrayIndex; i++) {
      Cell nextCell = new Cell("N", (i+arrayIndex));
      cellArray.add(nextCell);
    }
    arrayIndex += neurons;

    for (int i = arrayIndex; i < photoSensors + arrayIndex; i++) {
      Cell nextCell = new Cell("P", (i+arrayIndex));
      cellArray.add(nextCell)
    }
    arrayIndex += photoSensors;

    for (int i = arrayIndex; i < irSensors + arrayIndex; i++) {
      Cell nextCell = new Cell("R", (i+arrayIndex));
      cellArray.add(nextCell)
    }
    arrayIndex += irSensors;

    for (int i = arrayIndex; i < leftMotors + arrayIndex; i++) {
      Cell nextCell = new Cell("LM", (i+arrayIndex));
      cellArray.add(nextCell)
    }
    arrayIndex += leftMotors;

    for (int i = arrayIndex; i < rightMotors + arrayIndex; i++) {
      Cell nextCell = new Cell("RM", (i+arrayIndex));
      cellArray.add(nextCell)
    }
    arrayIndex += rightMotors;
  }

  void addConnection(int i, int j) {
    Connection newConnection = new Connection(i, j);
    connectionVector.add(newConnection);
  }

  void moveCells() {
    for (int i = 0; i < numberOfCells; i ++) {
      cellArray[i]->moveAndMorphCell();
      cellArray[i]->setCellSpeedAndGrowth();
    }
  }

  void recordIntersections() {
    for (int i = 0; i < numberOfCells; i++) {
      for (int j = i+1; j < numberOfCells; j++) {

        Cell celli = cellArray[i];
        Cell cellj = cellArray[j];

        float ixPos = celli->xPos;
        float iyPos = celli->yPos;
        float jxPos = cellj->xPos;
        float jyPos = cellj->yPos;

        // constant variables added for ease of readability

        if (!hasConnection(i, j)) { // if no connection has been recorded yet

          if (((celli->radius + cellj->radius) > distanceBetween(ixPos, iyPos, jxPos, jyPos)) &&
            (celli->diameter > 0) &&
            (cellj->diameter > 0)) { // if the two have spawned and are overlapping
            //
            // there are more concise and efficient ways of writing this but I have chosen this for ease of readability
            if (celli->isNeuron()) {
              if (cellj->isNeuron()) { // connect
                addConnection(i, j);
              } else if (cellj->isMotor()) { // connect
                addConnection(i, j);
              } else if (cellj->isSensor()) { // connect
                addConnection(i, j);
              }
            } else if (celli->isMotor()) {
              if (cellj->isNeuron()) { // connect
                addConnection(i, j);
              } else if (cellj->isMotor()) { // don't connect
                // do nothing
              } else if (cellj->isSensor()) { // connect
                addConnection(i, j);
              }
            } else if (celli->isSensor()) {
              if (cellj->isNeuron()) { // connect
                addConnection(i, j);
              } else if (cellj->isMotor()) { // connect
                addConnection(i, j);
              } else if (cellj->isSensor()) { // don't connect
                // do nothing
              }
            }
          }
        }
      }
    }
  }

  void updateAllConnectionPositions() {
    int links = connectionVector.size();
    for (int i = 0; i < links; i++) {
      connectionVector[i]->updateThisConnectionPosition();
      //links = connectionVector.size(); // recalculate as items will be added to list dynamically (should be unnecessary now)
    }
  }


  bool hasSpecificDirectionalConnection(int cellFromIndex, int cellToIndex) {
    int links = connectionVector.size();
    for (int i = 0; i < links; i++) {
      if (connectionVector[i]->isConnectionFromFirstToSecond(cellFromIndex, cellToIndex)) {
        //then there is a connection and we return true
        return true;
      }
    }
    // else return false as no connection exists yet
    return false;
  }

  bool hasConnection(int cell1Index, int cell2Index) {
    int links = connectionVector.size();
    for (int i = 0; i < links; i++) {
      if ((connectionVector[i]->isConnectionFromFirstToSecond(cell1Index, cell2Index)) || // if from cell1 to cell2
        (connectionVector[i]->isConnectionFromFirstToSecond(cell2Index, cell1Index))) {// or if from cell2 to cell1
        //then there is a connection and we return true
        return true;
      }
      //links = connectionVector.size();// recalculate as items will be added to list dynamically (should be unnecessary now)
    }
    // else return false as no connection exists yet
    return false;
  }

  float getSpecificDirectionalConnectionWeight(int cellFromIndex, int cellToIndex) {
    int links = connectionVector.size();
    for (int i = 0; i < links; i++) {
      if (connectionVector[i]->isConnectionFromFirstToSecond(cellFromIndex, cellToIndex)) {
        return connectionVector[i]->connectionWeight;
      }
    }
    print("This should never print, check getSpecificDirectionalConnectionWeight() for mistakes");
    return 0;
  }


}
