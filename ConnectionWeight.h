#include "Cell.h"

#ifndef CONNECTIONWEIGHT_H_INCLUDED
#define CONNECTIONWEIGHT_H_INCLUDED

float calculateConnectionWeight(Cell cellFrom, Cell cellTo);
float getConnectionWeight(Cell cellFrom, Cell cellTo);

int getConnectionDirection(Cell cellFrom, Cell cellTo);

bool inRange(float x, float[] range);

#endif
