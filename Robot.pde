class Robot {

  SensorArray sensorArray;
  Phenotype phenotype;

  Robot(SensorArray tempSensorArray, Phenotype tempPhenotype) {
    sensorArray = tempSensorArray;
    phenotype = tempPhenotype;
  }

  void printRobot() {
    println("Physical Sensor Attachments by Index:");
    for (int i = 0; i < numberOfSensors; i ++) {
      int sensorConnections = sensorArray.sensorDotArray[i].connections.size();
      print("Index " + i + ":");
      for (int j = 0; j < sensorConnections; j++) {
        if (j == 0) {
          print(sensorArray.sensorDotArray[i].connections.get(j));
        } else {
          print(", " +  sensorArray.sensorDotArray[i].connections.get(j));
        }
      }
      println();
    }
    println();
    println("Cell Genotypes:");

    for (int i = 0; i < phenotype.numberOfCells; i++) {
      println("Index " + i + ":");
      printGenotype(phenotype.cellArray[i].genotype);
    }
    println("=============================");

    println();
    println("Cell Uphill Connections by Index:");
    for (int i = 0; i < phenotype.numberOfCells; i++) {
      println("Index " + i + ":");
      for (int j = 0; j < phenotype.cellArray[i].cellConnections.size(); j++) {
        if (j == 0) {
          print(phenotype.cellArray[i].cellConnections.get(j));
        } else {
          print(", " +  phenotype.cellArray[i].cellConnections.get(j));
        }
      }
    }

    println();
    println("Cell Downhill Connections by Index:");
    for (int i = 0; i < phenotype.numberOfCells; i++) {
      println("Index " + i + ":");
      for (int j = 0; j < phenotype.cellArray[i].cellConnections.size(); j++) {
        if (j == 0) {
          print(phenotype.cellArray[i].cellConnections.get(j));
        } else {
          print(", " +  phenotype.cellArray[i].cellConnections.get(j));
        }
      }
    }
  }
}
