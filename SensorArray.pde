class SensorArray {

  SensorDot[] sensorDotArray = new SensorDot[16];

  SensorArray() {
    // nothing needed here yet, this class exists for organization
  }

  void drawIntersections(Phenotype phenotype) {

    for (int i = 0; i < 16; i++) {
      for (int j = 0; j < sensorDotArray[i].connections.size(); j++) {
        int cellIndex = sensorDotArray[i].connections.get(j);
        stroke(200, 50, 0);
        strokeWeight(3);
        line(sensorDotArray[i].xPos, sensorDotArray[i].yPos, phenotype.cellArray[cellIndex].xPos, phenotype.cellArray[cellIndex].yPos);
        stroke(0);
        strokeWeight(1);
      }
    }
  }

  void recordIntersections(Phenotype phenotype) {
    int cellsInPhenotype = phenotype.cellArray.length;
    for (int i = 0; i < cellsInPhenotype; i++) {
      if (isCellOverlappingWithHexadecagon(phenotype.cellArray[i])) {
        float tempAngle = degrees(phenotype.cellArray[i].genotype.theta);
        float angle;
        if(tempAngle < 0){ // add 360 to get rid of negative angle
          angle = tempAngle + 360;
        } else {
          angle = tempAngle;
        }
        int sensorIndex = getIndexOfClosestSensorDotToAngle(angle);
        if (!sensorDotArray[sensorIndex].connections.contains(i)) {
          sensorDotArray[sensorIndex].connections.add(i);
        }
      }
    }
  }

  void drawSensors() {
    float lastX = 0;
    float lastY = 0;
    float x = 0;
    float y = 0;
    for (float i = 0; i < 360; i += hexadecagonalTriangleInnerAngle) {
      lastX = x;
      lastY = y;
      x = polarX(i);
      y = polarY(i);

      int sensorArrayIndex = int(i/hexadecagonalTriangleInnerAngle);
      fill(0);
      text(sensorArrayIndex, x, y);
      sensorDotArray[sensorArrayIndex].drawSensorDot();

      if (i > 0) {
        line(lastX, lastY, x, y);
      }
    }
    line(x, y, polarX(0), polarY(0));
  }

  void initializeSensors(float dotSize) {
    float lastX = 0;
    float lastY = 0;
    float x = 0;
    float y = 0;
    for (float i = 0; i < 360; i += hexadecagonalTriangleInnerAngle) {
      lastX = x;
      lastY = y;
      x = polarX(i);
      y = polarY(i);

      int sensorArrayIndex = int(i/hexadecagonalTriangleInnerAngle);
      fill(0);
      text(sensorArrayIndex, x, y);
      sensorDotArray[sensorArrayIndex] = new SensorDot(x, y, dotSize);
      sensorDotArray[sensorArrayIndex].drawSensorDot();

      if (i > 0) {
        line(lastX, lastY, x, y);
      }
    }
    line(x, y, polarX(0), polarY(0));
  }
}
