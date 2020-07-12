int[] toArray(ArrayList<Integer> arrayList) {
  int size = arrayList.size();
  int[] array = new int[size];
  for (int i = 0; i<size; i ++) {
    array[i] = arrayList.get(i);
  }

  return array;
}

void printIntegerMatrix(int[][] integerMatrix) {
  for (int i = 0; i < integerMatrix.length; i++) {
    print(i + ": ");
    int innerSize = integerMatrix[i].length;
    for (int j = 0; j < innerSize; j++) {
      print("[" + integerMatrix[i][j] + "] ");
    }
    println();
  }
  println();
}

void printFloatMatrix(float[][] floatMatrix) {
  for (int i = 0; i < floatMatrix.length; i++) {
    print("____" + i + "___" );
  }
  println();
  for (int i = 0; i < floatMatrix.length; i++) {
    print(i + ": ");
    int innerSize = floatMatrix[i].length;
    for (int j = 0; j < innerSize; j++) {
      print("[" + nf(floatMatrix[i][j], 0, 3) + "] ");
    }
    println();
  }
  println();
}

void printBooleanMatrix(boolean[][] booleanMatrix) {
  for (int i = 0; i < booleanMatrix.length; i++) {
    print("____" + i + "___" );
  }
  println();
  for (int i = 0; i < booleanMatrix.length; i++) {
    print(i + ": "); 
    int innerSize = booleanMatrix[i].length; 
    for (int j = 0; j < innerSize; j++) {
      print("[" + booleanMatrix[i][j] + "] ");
    }
    println();
  }
  println();
}

class Robot {

  SensorArray sensorArray; 
  Phenotype phenotype; 
  Cell[] cellArray; 
  int numberOfCells = 0; 

  int numberOfNeurons = 0; 
  int numberOfPhotoSensors = 0; 
  int numberOfIRSensors = 0; 
  int numberOfRightMotors = 0; 
  int numberOfLeftMotors = 0; 

  int[][] attachmentsBySensorIndex = new int[numberOfSensors][]; // x is sensor index, y will be an array of attachments by their cell array index
  boolean[][] cellConnections; 
  float[][] cellConnectionWeights; 


  Robot(SensorArray tempSensorArray, Phenotype tempPhenotype) {
    sensorArray = tempSensorArray; 
    phenotype = tempPhenotype; 

    cellArray = phenotype.cellArray; 

    for (int i = 0; i < cellArray.length; i++) {
      switch (cellArray[i].genotype.cellType) {
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
      int[] connectionArray = toArray(sensorArray.sensorDotArray[i].connections); 
      attachmentsBySensorIndex[i] = connectionArray;
    }

    cellConnections = new boolean[numberOfCells][numberOfCells]; 
    cellConnectionWeights = new float[numberOfCells][numberOfCells]; 

    for (int x = 0; x < numberOfCells; x++) {
      for (int y = 0; y < numberOfCells; y++) {
        if (cellArray[x].hasSpecificDirectionalConnection(x, y)) {
         
          cellConnections[x][y] = true; 
          float connectionWeight = cellArray[x].getSpecificDirectionalConnectionWeight(x, y); 
          cellConnectionWeights[x][y] = connectionWeight; 
        } else if (cellArray[x].hasSpecificDirectionalConnection(y, x)) {
          cellConnections[y][x] = true; 
          float connectionWeight = cellArray[x].getSpecificDirectionalConnectionWeight(y, x); 
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
    printBooleanMatrix(cellConnections); 
    println("Connection Weights by Index, X to Y:"); 
    printFloatMatrix(cellConnectionWeights);
  }
}
