#include "Genotype.h"
#include <string>

#ifndef CELL_H_INCLUDED
#define CELL_H_INCLUDED

// class Connection;

class Cell {
public:
  int index;
  // ArrayList<Connection> cellConnections; // moved to Phenotype

  Genotype genotype;
  float xPos;
  float yPos;
  float diameter;
  float radius;

  float xSpeed;
  float ySpeed;
  float growthRate;

  bool doneMoving;
  bool doneGrowing;

  Cell(string cellType, int tempIndex);

  bool isMotor();
  bool isSensor();
  bool isNeuron();

  void setCellSpeedAndGrowth();
  void moveAndMorphCell();
  void printGenes();
};

#endif
