#include "Cell.h"
#include "GenerateGene.h"
#include <iostream>

class Cell {
  int index;
  // ArrayList<Connection> cellConnections = new ArrayList<Connection>();

  Genotype genotype;
  float xPos = 0;
  float yPos = 0;
  float diameter = 0;
  float radius = 0;

  float xSpeed = 0;
  float ySpeed = 0;
  float growthRate = 0;

  bool doneMoving = false;
  bool doneGrowing = false;

  Cell(string cellType, int tempIndex) {
    genotype = returnRandomNewGenotype(cellType);
    index = tempIndex;
  }

  bool isMotor() {
    if (genotype->cellType == "LM" || genotype->cellType == "RM") {
      return true;
    } else {
      return false;
    }
  }

  bool isSensor() {
    if (genotype->cellType == "R" || genotype->cellType == "P") {
      return true;
    } else {
      return false;
    }
  }

  bool isNeuron() {
    if (genotype->cellType == "N") {
      return true;
    } else {
      return false;
    }
  }

  void setCellSpeedAndGrowth() {
    if (currentTick > genotype->growthDelay) {
      growthRate = (genotype->growthRate / actionSpread);
    }

    if (currentTick > genotype->movementDelay) {
      float speed = (genotype->speed / actionSpread);
      xSpeed = speed * cos(genotype->theta);
      ySpeed = speed * sin(genotype->theta);
    }
  }

  void moveAndMorphCell() {
    if (!doneMoving && (currentTick - genotype->movementDelay < genotype->movementDuration)) {
      xPos += xSpeed;
      yPos -= ySpeed;
    } else {
      doneMoving = true;
    }

    if (!doneGrowing && (currentTick - genotype->growthDelay < genotype->growthDuration)) {
      diameter += growthRate;
      radius = diameter/2;
    } else {
      doneGrowing = true;
    }
  }

  void printGenes() {
    printGenotype(genotype);
  }
}
