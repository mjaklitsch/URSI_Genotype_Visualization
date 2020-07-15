#include "Cell.h"

#ifndef POLYGONALCALCULATIONS_H_INCLUDED
#define POLYGONALCALCULATIONS_H_INCLUDED
float radians(float degrees);
float degrees(float radians);
float polarXAngle(float angle);
float polarYAngle(float angle);
float polarXTheta(float theta);
float polarYTheta(float theta);
float distanceBetween(float xPos1, float yPos1, float xPos2, float yPos2);
float getPolygonDistanceFromOriginAtTheta(float theta);
float getxCoordinateOfPolygonAtTheta(float theta);
float getyCoordinateOfPolygonAtTheta(float theta);

float[] getMidpoint(float x1, float y1, float x2, float y2);
float[] getTextLabelPosition(float x1, float y1, float x2, float y2);

int getIndexOfClosestSensorDotToTheta(float theta);

bool isCellOverlappingWithPolygon(Cell cell);

#endif
