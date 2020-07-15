#include "random.h"
#include <iostream>

int intRandom(int low, int high){
  int r3 = low + static_cast <int> (rand()) /( static_cast <int> (RAND_MAX/(high-low)));
  return r3;
}

float floatRandom(float low, float high){
  float r3 = low + static_cast <float> (rand()) /( static_cast <float> (RAND_MAX/(high-low)));
  return r3;
}
