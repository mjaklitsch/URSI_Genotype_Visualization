#include "ConnectionWeight.h"
#include <iostream>

// double PI = 2*acos(0.0);

bool inRange(float x, float[] range) {
  if (x >= range[0] && x < range[1]) {
    return true;
  } else {
    return false;
  }
}

int getConnectionDirection(Cell cellFrom, Cell cellTo) {

  float fromTheta = cellFrom->genotype->theta;
  float toTheta = cellTo->genotype->theta;

  // index: 0 = low, 1 = high
  // 4 range arrays, 2 for each direction, one extends to the maximum range(2PI or 0), the other restarts from the other side and accounts for the remainder
  // for example with angle of 270:
  // range 1: 270 - 360, range 2: 0 - 90, accounts for a full 180 degrees counterclockwise
  // range 3: 90 - 270, range 4: also 90 - 270 as no overlap with the boundary occurs, accounts for 180 degrees clockwise

  //        90
  //      / | \      // a very angular unit circle diagram
  // 180 ------- 0/360
  //      \ | /
  //       270

  float[] rangeCounterClockwise = new float[2];
  float[] rangeCounterClockwise2 = new float[2];
  float[] rangeClockwise = new float[2];
  float[] rangeClockwise2 = new float[2];

  if (fromTheta <= PI) {
    rangeCounterClockwise[0] = fromTheta;
    rangeCounterClockwise[1] = fromTheta + PI;
    rangeCounterClockwise2[0] = fromTheta;
    rangeCounterClockwise2[1] = fromTheta + PI;

    rangeClockwise[0] = 0;
    rangeClockwise[1] = fromTheta;
    rangeClockwise2[0] = fromTheta + PI;
    rangeClockwise2[1] = 2*PI;
  } else {
    rangeCounterClockwise[0] = fromTheta;
    rangeCounterClockwise[1] = 2*PI;
    rangeCounterClockwise2[0] = 0;
    rangeCounterClockwise2[1] = fromTheta - PI;

    rangeClockwise[0] = fromTheta - PI;
    rangeClockwise[1] = fromTheta;
    rangeClockwise2[0] = fromTheta - PI;
    rangeClockwise2[1] = fromTheta;
  }

  if (inRange(toTheta, rangeCounterClockwise) || inRange(toTheta, rangeCounterClockwise2)) {
    return -1;
  } else if (inRange(toTheta, rangeClockwise) || inRange(toTheta, rangeClockwise2)) {
    return 1;
  } else {
    return 0; // should never return
  }
}

float getConnectionWeight(Cell cellFrom, Cell cellTo) {
  float weight;
  //if (cellTo->isSensor()) {

  if (cellTo->diameter < cellFrom->diameter) {
    weight = cellTo->diameter / cellFrom->diameter;
  } else {
    weight = cellFrom->diameter / cellTo->diameter;
  }

  return weight;
}
float calculateConnectionWeight(Cell cellFrom, Cell cellTo) {
  float weight = getConnectionWeight(cellFrom, cellTo);
  int direction = getConnectionDirection(cellFrom, cellTo);

  return direction * weight;
}
