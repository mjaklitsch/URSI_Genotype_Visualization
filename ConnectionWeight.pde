float calculateConnectionWeight(Cell cellFrom, Cell cellTo) {
  float weight = cellFrom.diameter / cellTo.diameter;


  return getConnectionDirection(cellFrom, cellTo) * weight;
}

int getConnectionDirection(Cell cellFrom, Cell cellTo) {

  float fromTheta = cellFrom.genotype.theta;
  float toTheta = cellTo.genotype.theta;

  // index: 0 = low, 1 = high
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
  } else if (inRange(toTheta, rangeClockwise) || inRange(toTheta, rangeClockwise2)){
    return 1;
  } else {
    return 0; // should never return
  }
  
}

boolean inRange(float x, float[] range) {
  if (x >= range[0] && x < range[1]) {
    return true;
  } else {
    return false;
  }
}
