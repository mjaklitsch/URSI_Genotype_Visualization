float calculateConnectionWeight(Cell cellFrom, Cell cellTo) {
  float weight = getConnectionWeight(cellFrom, cellTo);
  int direction = getConnectionDirection(cellFrom, cellTo);


  return direction * weight;
}

float getConnectionWeight(Cell cellFrom, Cell cellTo) {
  float weight;
  if (cellTo.isSensor()) {
    if (cellTo.diameter < cellFrom.diameter) {
      weight = cellTo.diameter / cellFrom.diameter;
    } else {
      weight = cellFrom.diameter / cellTo.diameter;
    }
  } else if (cellFrom.isSensor()) {
    if (cellFrom.diameter < cellTo.diameter) {
      weight = cellFrom.diameter / cellTo.diameter;
    } else {
      weight = cellTo.diameter / cellFrom.diameter;
    }
  } else {
    if (cellFrom.diameter < cellTo.diameter) {
      weight = cellFrom.diameter / cellTo.diameter;
    } else {
      weight = cellTo.diameter / cellFrom.diameter;
    }
  }

  return weight;
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
  } else if (inRange(toTheta, rangeClockwise) || inRange(toTheta, rangeClockwise2)) {
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

//boolean isConnectionDirectionFrom(Cell cell1, /*To*/ Cell cell2){ 

//  if(cell1.genotype.cellType == "P" || cell1.genotype.cellType == "R"){ //|| cell1.genotype.cellType == "LM" || cell1.genotype.cellType == "RM"){
//    if(cell2.isNeuron() || cell2.genotype.cellType == "LM" || cell2.genotype.cellType == "RM"){
//      return true;
//    }
//  } else if(cell1.isNeuron()){

//  }

//}
