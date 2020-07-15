#include "PolygonCalculations.h"
#include <cmath>
#include <iostream>

// double PI = 2*acos(0.0);

int polygonRadius = 300;

float polygonalTriangleInnerTheta = (2*PI) / numberOfSensors;
float polygonalTriangleOuterTheta = (PI - polygonalTriangleInnerTheta) / 2; //see below
//   center (Inner Angle)
//     /\
//    /  \
//   /    \
//  /______\
//  ^ these ^ angles (Outer Angles)

float radians(float degrees){
  return degrees * PI / 180;
}

float degrees(float radians){
  return radians * 180 / PI;
}

float polarXAngle(float angle) { // takes theta(polar coordinate) and returns the corresponding cartesian X coordinate for the global polygon size
  return cos(radians(angle))*polygonRadius;
}

float polarYAngle(float angle) { // takes theta(polar coordinate) and returns the corresponding cartesian Y coordinate for the global polygon size
  return sin(radians(angle))*polygonRadius;
}

float polarXTheta(float theta) { // takes theta(polar coordinate) and returns the corresponding cartesian X coordinate for the global polygon size
  return cos(theta)*polygonRadius;
}

float polarYTheta(float theta) { // takes theta(polar coordinate) and returns the corresponding cartesian Y coordinate for the global polygon size
  return sin(theta)*polygonRadius;
}

float distanceBetween(float xPos1, float yPos1, float xPos2, float yPos2) {
  float distance = sqrt(pow(xPos2 - xPos1, 2) + pow(yPos2 - yPos1, 2));
  return distance;
}

float getPolygonDistanceFromOriginAtTheta(float theta) {

  float scaledTheta = theta % polygonalTriangleInnerTheta; // reduce problem to single triangle
  float edgeTheta = PI - (scaledTheta + polygonalTriangleOuterTheta); // get angle produced by cell's angle of incident on polygon's outer edge
  float polygonDistanceFromOrigin = (polygonRadius * sin(polygonalTriangleOuterTheta)) / (sin(edgeTheta)); // law of sines to get length from center to edge of polygon at that angle
  return polygonDistanceFromOrigin;
}

int getIndexOfClosestSensorDotToTheta(float theta) {
  int inverseIndex = round(theta / polygonalTriangleInnerTheta);// the sensors are indexed incrementally clockwise whereas...
  if (inverseIndex == 0) { // ...angles increase counterclockwise (in an attempt to mimick the unit circle)...
    return 0;
  } else {
    return numberOfSensors - inverseIndex; // ...which makes this inverse measurement necessary
  }
}

//bool isCellOverlappingWithPolygon(Cell cell) { // deprecated because it doesnt actually work

//  float centerOfCircleDistanceFromOrigin = distanceBetween(cell.xPos, cell.yPos, 0, 0);
//  float edgeOfCircleDistanceFromOrigin = centerOfCircleDistanceFromOrigin + cell.radius;
//  float polygonDistanceFromOrigin = getPolygonDistanceFromOriginAtAngle(degrees(cell.genotype.theta));

//  if (edgeOfCircleDistanceFromOrigin >= polygonDistanceFromOrigin) {
//    return true;
//  } else {
//    return false;
//  }
//}
float getxCoordinateOfPolygonAtTheta(float theta) {
  float xCoordOfPolygon = getPolygonDistanceFromOriginAtTheta(theta) * cos(theta);
  return xCoordOfPolygon;
}

float getyCoordinateOfPolygonAtTheta(float theta) {
  float yCoordOfPolygon = -getPolygonDistanceFromOriginAtTheta(theta) * sin(theta);
  return yCoordOfPolygon;
}

bool isCellOverlappingWithPolygon(Cell cell) {
  float theta = cell->genotype->theta;
  float xCoordOfPolygonAtTheta = getxCoordinateOfPolygonAtTheta(theta);
  float yCoordOfPolygonAtTheta = getyCoordinateOfPolygonAtTheta(theta);
  float thetaOfCircleTangentWithPolygon = abs((theta % polygonalTriangleInnerTheta)-(polygonalTriangleInnerTheta/2));

  float cosThetaOfTangent = cos(thetaOfCircleTangentWithPolygon);

  float distanceFromTargetPointOfPolygonToCenterOfCell = distanceBetween(cell->xPos, cell->yPos, xCoordOfPolygonAtTheta, yCoordOfPolygonAtTheta);
  float distanceFromClosestPointOfPolygonToCenterOfCell = distanceFromTargetPointOfPolygonToCenterOfCell * cosThetaOfTangent;

  if (distanceFromClosestPointOfPolygonToCenterOfCell <= cell->radius) {
    return true;
  } else {
    return false;
  }
}

float[] getMidpoint(float x1, float y1, float x2, float y2) {
  float[] midpoint = new float[2];

  float x3 = (x1 + x2) / 2;
  float y3 = (y1 + y2) / 2;

  midpoint[0] = x3;
  midpoint[1] = y3;

  return midpoint;
}

float[] getTextLabelPosition(float x1, float y1, float x2, float y2) {
  float[] textLabelPosition = getMidpoint(x1, y1, x2, y2);

  textLabelPosition[0] += 0; // shift position right
  textLabelPosition[1] -= 10; // shift position up

  return textLabelPosition;
}
