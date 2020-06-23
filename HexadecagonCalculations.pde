int hexadecagonRadius = 300;
float hexadecagonalTriangleInnerAngle = 22.5;
float hexadecagonalTriangleOuterAngle = 78.75; //see below
//   center (Inner Angle)
//     /\
//    /  \
//   /    \
//  /______\
//  ^ these ^ angles (Outer Angles)


float polarX(float angle) { // takes angle
  return cos(radians(angle))*hexadecagonRadius;
}

float polarY(float angle) { // takes angle
  return sin(radians(angle))*hexadecagonRadius;
}

void plotHexadecagon(int dotSize) {
  float lastX = 0;
  float lastY = 0;
  float x = 0;
  float y = 0;
  for (float i = 0; i < 360; i += hexadecagonalTriangleInnerAngle) {
    lastX = x;
    lastY = y;
    x = polarX(i);
    y = polarY(i);
    ellipse(x, y, dotSize, dotSize);
    if (i > 0) {
      line(lastX, lastY, x, y);
    }
  }
  line(x, y, polarX(0), polarY(0));
}

float distanceBetween(float xPos1, float yPos1, float xPos2, float yPos2){
  float distance = sqrt(sq(xPos2 - xPos1) + sq(yPos2 - yPos1));
  return distance;
}

float getHexSizeAtAngle(float angle){
  float scaledAngle = angle % hexadecagonalTriangleInnerAngle;
  float edgeAngle =  180 - (scaledAngle + hexadecagonalTriangleOuterAngle);
  float hexSize = (hexadecagonRadius * sin(hexadecagonalTriangleOuterAngle)) / (sin(edgeAngle));
  return hexSize;
}
