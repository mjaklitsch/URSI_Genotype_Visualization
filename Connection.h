#include "Cell.h"

#ifndef CONNECTION_H_INCLUDED
#define CONNECTION_H_INCLUDED

class Connection {
public:
    float x1;
    float y1;
    float x2;
    float y2;
    float connectionWeight;

    Cell* cell1;
    Cell* cell2;

    // int cell1Index;
    // int cell2Index;

    float xFrom;
    float yFrom;
    float xTo;
    float yTo;

    Cell* cellFrom; // use this to figure out if a swap happened
    Cell* cellTo;

    int cellFromIndex;
    int cellToIndex;

    bool hasUncheckedNeuronalConnection;
    bool connectionIsCompletese;

  Connection(int tempCellFromIndex, int tempCellToIndex, Cell* tempCell1, Cell* tempCell2);

  void updateThisConnectionPosition();
  void setCellToAndCellFrom();

  bool isConnectionFromFirstToSecond(int first, int second);
};

#endif
