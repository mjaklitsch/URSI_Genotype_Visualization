int hexadecagonRadius = 300;
float hexadecagonalTriangleInnerAngle = 22.5;
float hexadecagonalTriangleOuterAngle = 78.75; //see below
//   center (Inner Angle)
//     /\
//    /  \
//   /    \
//  /______\
//  ^ these ^ angles (Outer Angles)


float polarX(float angle) { // takes angle(polar coordinate) and returns the corresponding cartesian X coordinate for the global hexadecagon size
  return cos(radians(angle))*hexadecagonRadius;
}

float polarY(float angle) { // takes angle(polar coordinate) and returns the corresponding cartesian Y coordinate for the global hexadecagon size
  return sin(radians(angle))*hexadecagonRadius;
}

//void plotHexadecagon() { // redundant with SensorArray.plotSensors(float dotSize)
//  float lastX = 0;
//  float lastY = 0;
//  float x = 0;
//  float y = 0;
//  for (float i = 0; i < 360; i += hexadecagonalTriangleInnerAngle) {
//    lastX = x;
//    lastY = y;
//    x = polarX(i);
//    y = polarY(i);
//    if (i > 0) {
//      line(lastX, lastY, x, y);
//    }
//  }
//  line(x, y, polarX(0), polarY(0));
//}

float distanceBetween(float xPos1, float yPos1, float xPos2, float yPos2) {
  float distance = sqrt(sq(xPos2 - xPos1) + sq(yPos2 - yPos1));
  return distance;
}

float getHexDistanceFromOriginAtAngle(float angle) {
  
  float scaledAngle = angle % hexadecagonalTriangleInnerAngle; // reduce problem to single triangle
  float edgeAngle =  180 - (scaledAngle + hexadecagonalTriangleOuterAngle); // get angle produced by cell's angle of incident on hexadecagon's outer edge
  float hexSize = (hexadecagonRadius * sin(radians(hexadecagonalTriangleOuterAngle))) / (sin(radians(edgeAngle))); // law of sines to get length from center to edge of hexadecagon at that angle
  return hexSize;
}

int getIndexOfClosestSensorDotToAngle(float angle) {
  int inverseIndex = round(angle / hexadecagonalTriangleInnerAngle);// the sensors are indexed incrementally clockwise whereas...
  if (inverseIndex == 0) {
    return 0; //
  } else {
    return 16 - inverseIndex; // ...angles increase counterclockwise (in an attempt to mimick the unit circle) which makes this inverse measurement necessary
  }
}

boolean isCellOverlappingWithHexadecagon(Cell cell) {

  float centerOfCircleDistanceFromOrigin = distanceBetween(cell.xPos, cell.yPos, 0, 0);
  float edgeOfCircleDistanceFromOrigin = centerOfCircleDistanceFromOrigin + cell.radius;
  float hexDistanceFromOrigin = getHexDistanceFromOriginAtAngle(degrees(cell.genotype.theta));

  //print("hex distance: " + hexDistanceFromOrigin);
  //println();
  //print("circle distance: " + edgeOfCircleDistanceFromOrigin);
  //println();
  //println();
  if (edgeOfCircleDistanceFromOrigin > hexDistanceFromOrigin) {
    return true;
  } else {
    return false;
  }
}

void arrow(int x1, int y1, int x2, int y2) {
  strokeWeight(2);
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
  strokeWeight(1);
}
