class Connection {

  float checksum = random(0, 1000); // even if this is only to 2 decimal places it has a 1/100000 chance of a repeat

  float xFrom;
  float yFrom;
  float xTo;
  float yTo;
  float connectionWeight;

  Cell cellFrom; // use this to figure out if a swap happened
  Cell cellTo;

  int cellFromIndex;
  int cellToIndex;

  boolean hasUncheckedNeuronalConnection = false;
  boolean connectionIsComplete = false;

  Connection(int tempCellFromIndex, Cell tempCellFrom, int tempCellToIndex, Cell tempCellTo, float tempConnectionWeight, boolean tempHasUncheckedNeuronalConnection) {
    cellFrom = tempCellFrom;
    cellTo = tempCellTo;

    cellFromIndex = tempCellFromIndex;
    cellToIndex = tempCellToIndex;

    xFrom = cellFrom.xPos;
    yFrom = cellFrom.yPos;
    xTo = cellTo.xPos;
    yTo = cellTo.yPos;

    connectionWeight = tempConnectionWeight;

    hasUncheckedNeuronalConnection = tempHasUncheckedNeuronalConnection;
    connectionIsComplete = !tempHasUncheckedNeuronalConnection;
  }

  void fixNeuronalConnectionDirection() { 
    if (hasUncheckedNeuronalConnection) {
      if (cellFrom.isSensor() || cellTo.isMotor()) { // if sensors are giving data to a neuron or a neuron is giving data to a motor, the connection is correct
        int neurolinks = cellTo.neuronalConnections.size();
        for (int i = neurolinks - 1; i >= 0; i--) {
          //if (i < cellTo.neuronalConnections.size()) {
            if (checksum == cellTo.neuronalConnections.get(i).checksum) {
              cellTo.uphillConnections.add(cellTo.neuronalConnections.get(i));
              cellTo.neuronalConnections.remove(i);
              break;
            }
          //}
        }
        neurolinks = cellFrom.neuronalConnections.size();
        for (int i = neurolinks - 1; i >= 0; i--) {
          //if (i < cellFrom.neuronalConnections.size()) {
            if (checksum == cellFrom.neuronalConnections.get(i).checksum) {
              cellFrom.downhillConnections.add(cellFrom.neuronalConnections.get(i));
              cellFrom.neuronalConnections.remove(i);
              break;
            }
          //}
        }
        hasUncheckedNeuronalConnection = false;
        return;
      } else if (cellTo.isSensor() || //  if a sensor is receiving data or...
        ((cellTo.isNeuron() && cellFrom.isNeuron()) && (cellFrom.diameter < cellTo.diameter))) { // ... a small neuron is giving data to a large neuron, the connection is incorrect
        swapConnectionToFrom();
        int neurolinks = cellTo.neuronalConnections.size();
        for (int i = neurolinks - 1; i >= 0; i--) {
          //if (i < cellTo.neuronalConnections.size()) {
            if (checksum == cellTo.neuronalConnections.get(i).checksum) {
              cellTo.uphillConnections.add(cellTo.neuronalConnections.get(i));
              cellTo.neuronalConnections.remove(i);
              break;
            }
          //}
        }
        neurolinks = cellFrom.neuronalConnections.size();
        for (int i = neurolinks - 1; i >= 0; i--) {
          //if (i < cellFrom.neuronalConnections.size()) {
            if (checksum == cellFrom.neuronalConnections.get(i).checksum) {
              cellFrom.downhillConnections.add(cellFrom.neuronalConnections.get(i));
              cellFrom.neuronalConnections.remove(i);
              break;
            }
          //}
        }
        hasUncheckedNeuronalConnection = false;
        return;
      }
    }
  }


  void swapConnectionToFrom() {
    Cell tempCellFrom = cellFrom;
    cellFrom = cellTo;
    cellTo = tempCellFrom;
  }

  void updateThisConnectionPosition() {
    xFrom = cellFrom.xPos;
    yFrom = cellFrom.yPos;
    xTo = cellTo.xPos;
    yTo = cellTo.yPos;
    if (!connectionIsComplete) {
      if ((!(cellFrom.isNeuron()) || (cellFrom.doneGrowing == true && cellFrom.doneMoving == true)) && 
        (!(cellTo.isNeuron()) || (cellTo.doneGrowing == true && cellTo.doneMoving == true))) { // if both cells either are not a neuron, or are and are done moving/growing
        connectionWeight = calculateConnectionWeight(cellFrom, cellTo);
        fixNeuronalConnectionDirection(); 
        connectionIsComplete = true;
      }
    }
  }

  void drawThisConnection() {
    if (connectionIsComplete) {
      float[] weightPosition = getTextLabelPosition(xTo, yTo, xFrom, yFrom);
      stroke(0);
      fill(0);

      strokeWeight(1);
      text(connectionWeight, weightPosition[0], weightPosition[1]);
      arrow(int(xFrom), int(yFrom), int(xTo), int(yTo));
    } else {
      float[] weightPosition = getTextLabelPosition(xTo, yTo, xFrom, yFrom);
      stroke(0);
      fill(0);

      strokeWeight(1);
      text("Calculating...", weightPosition[0], weightPosition[1]);
      line(xFrom, yFrom, xTo, yTo);
    }
  }

  //void verifyAndCorrectConnectionDirection
}
