class SensorArray {

  SensorDot[] sensorDotArray = new SensorDot[numberOfSensors];

  SensorArray() {
    // nothing needed here yet, this class exists for organization
  }

  void drawIntersections(Phenotype phenotype) {

    for (int i = 0; i < numberOfSensors; i++) {
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
      if (isCellOverlappingWithPolygon(phenotype.cellArray[i])) {
        float tempTheta = phenotype.cellArray[i].genotype.theta;
        float theta;
        if (tempTheta < 0) { // add 2 PI to get rid of negative theta
          theta = tempTheta + (2 * PI);
        } else {
          theta = tempTheta;
        }
        int sensorIndex = getIndexOfClosestSensorDotToTheta(theta);
        if (!sensorDotArray[sensorIndex].connections.contains(i)) {
          sensorDotArray[sensorIndex].connections.add(i);
        }
      }
    }
  }
  
  final float polygonalTriangleInnerAngle = 360 / numberOfSensors;
  final float polygonalTriangleOuterAngle = (180 - polygonalTriangleInnerAngle) / 2; // only used for sensors
  
  void drawSensors() {
    float lastX = 0;
    float lastY = 0;
    float x = 0;
    float y = 0;
    for (float i = 0; i < 360; i += polygonalTriangleInnerAngle) {
      lastX = x;
      lastY = y;
      x = polarXAngle(i);
      y = polarYAngle(i);

      int sensorArrayIndex = int(i/polygonalTriangleInnerAngle);
      fill(0);

      float[] labelPosition = getTextLabelPosition(x, y, x, y);
      text(sensorArrayIndex, labelPosition[0], labelPosition[1]);
      sensorDotArray[sensorArrayIndex].drawSensorDot();

      if (i > 0) {
        line(lastX, lastY, x, y);
      }
    }
    line(x, y, polarXTheta(0), polarYTheta(0));
  }

  void initializeSensors(float dotSize) {
    float lastX = 0;
    float lastY = 0;
    float x = 0;
    float y = 0;
    for (float i = 0; i < 360; i += polygonalTriangleInnerAngle) {
      lastX = x;
      lastY = y;
      x = polarXAngle(i);
      y = polarYAngle(i);

      int sensorArrayIndex = int(i/polygonalTriangleInnerAngle);
      fill(0);
      text(sensorArrayIndex, x, y);
      sensorDotArray[sensorArrayIndex] = new SensorDot(x, y, dotSize);
      sensorDotArray[sensorArrayIndex].drawSensorDot();

      if (i > 0) {
        line(lastX, lastY, x, y);
      }
    }
    line(x, y, polarXTheta(0), polarYTheta(0));
  }
}
