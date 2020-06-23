int hexadecagonRadius = 300;
float hexadecagonalTriangleInnerAngle = 78.75; //see below
//   center
//     /\
//    /  \
//   /    \
//  /______\
//  ^ these ^ angles


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
  for (float i = 0; i < 360; i += 22.5) {
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

float getHexSizeAtAngle(float angle){
  float scaledAngle = angle % 22.5;
  float edgeAngle =  180 - (scaledAngle + hexadecagonalTriangleInnerAngle);
  float hexSize = (hexadecagonRadius * sin(hexadecagonalTriangleInnerAngle)) / (sin(edgeAngle));
  return hexSize;
}
