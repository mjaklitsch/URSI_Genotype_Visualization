#include "Robot.h"
#include <iostream>

void printIntegerMatrix(std::vector<std::vector<int> > integerMatrix) {
  for (int i = 0; i < integerMatrix.size(); i++) {
    print(i + ": ");
    int innerSize = integerMatrix[i].size();
    for (int j = 0; j < innerSize; j++) {
      print("[" + integerMatrix[i][j] + "] ");
    }
    println();
  }
  println();
}

void printFloatMatrix(std::vector<std::vector<float> > floatMatrix) {
  for (int i = 0; i < floatMatrix.size(); i++) {
    print("____" + i + "___" );
  }
  println();
  for (int i = 0; i < floatMatrix.size(); i++) {
    print(i + ": ");
    int innerSize = floatMatrix[i].size();
    for (int j = 0; j < innerSize; j++) {
      print("[" + nf(floatMatrix[i][j], 0, 3) + "] ");
    }
    println();
  }
  println();
}

void printboolMatrix(std::vector<std::vector<bool> > boolMatrix) {
  for (int i = 0; i < boolMatrix.size(); i++) {
    print("____" + i + "___" );
  }
  println();
  for (int i = 0; i < boolMatrix.size(); i++) {
    print(i + ": ");
    int innerSize = boolMatrix[i].size();
    for (int j = 0; j < innerSize; j++) {
      print("[" + boolMatrix[i][j] + "] ");
    }
    println();
  }
  println();
}

class Robot {

  SensorArray sensorArray;
  Phenotype phenotype;
  std::vector<Cell> cellArray;
  int numberOfCells = 0;

  int numberOfNeurons = 0;
  int numberOfPhotoSensors = 0;
  int numberOfIRSensors = 0;
  int numberOfRightMotors = 0;
  int numberOfLeftMotors = 0;

  std::vector<std::vector<int> > attachmentsBySensorIndex; // x is sensor index, y will be an array of attachments by their cell array index
  std::vector<std::vector<bool> > cellConnections;
  std::vector<std::vector<float> > cellConnectionWeights;


  Robot(SensorArray tempSensorArray, Phenotype tempPhenotype) {
    sensorArray = tempSensorArray;
    phenotype = tempPhenotype;

    cellArray = phenotype->cellArray;

    for (int i = 0; i < sizeOf(cellArray); i++) {
      switch (cellArray[i]->genotype->cellType) {
      case "N" :
        numberOfNeurons++;
        numberOfCells++;
        break;
      case "R" :
        numberOfIRSensors++;
        numberOfCells++;
        break;
      case "P" :
        numberOfPhotoSensors++;
        numberOfCells++;
        break;
      case "LM" :
        numberOfLeftMotors++;
        numberOfCells++;
        break;
      case "RM" :
        numberOfRightMotors++;
        numberOfCells++;
        break;
      }
    }

    for (int i = 0; i < numberOfSensors; i++) {
      std::vector<int> connectionArray = sensorArray->sensorDotArray[i]->connections;
      attachmentsBySensorIndex[i] = connectionArray;
    }

    // cellConnections = new bool[numberOfCells][numberOfCells];
    // cellConnectionWeights = new float[numberOfCells][numberOfCells];

    for (int x = 0; x < numberOfCells; x++) {
      for (int y = 0; y < numberOfCells; y++) {
        if (cellArray[x]->hasSpecificDirectionalConnection(x, y)) {

          cellConnections[x][y] = true;
          float connectionWeight = cellArray[x]->getSpecificDirectionalConnectionWeight(x, y);
          cellConnectionWeights[x][y] = connectionWeight;
        } else if (cellArray[x]->hasSpecificDirectionalConnection(y, x)) {
          cellConnections[y][x] = true;
          float connectionWeight = cellArray[x]->getSpecificDirectionalConnectionWeight(y, x);
          cellConnectionWeights[y][x] = connectionWeight;
        } else {
          cellConnections[x][y] = false;
          cellConnections[y][x] = false;
          cellConnectionWeights[x][y] = 0;
          cellConnectionWeights[y][x] = 0;
        }
      }
    }
  }

  void printRobot() {
    println("Number of Cells: " + numberOfCells);
    println("Number of Neurons: " + numberOfNeurons);
    println("Number of IR Sensors: " + numberOfIRSensors);
    println("Number of Photo Sensors: " + numberOfPhotoSensors);
    println("Number of Right Motors: " + numberOfRightMotors);
    println("Number of Left Motors: " + numberOfLeftMotors);
    println("Physical Sensor Attachments by Index:");
    printIntegerMatrix(attachmentsBySensorIndex);
    println("Connections by Index, X to Y:");
    printboolMatrix(cellConnections);
    println("Connection Weights by Index, X to Y:");
    printFloatMatrix(cellConnectionWeights);
  }
}
