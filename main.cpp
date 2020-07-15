#include "RunSimulation.h"
#include <iostream>

using namespace sim;

int main(){
  int ticks = 180;
  int framesPerTick = 6;
  int frames = 60;
  // int actionSpread = frames / framesPerTick;
  int actionSpread = 10;

  // Phenotype Generation Variables
  int minNeurons = 2;
  int minPhotosensors = 2;
  int minIRSensors = 2;
  int minLeftMotors = 1;
  int minRightMotors = 1;

  int maxNeurons = 4;
  int maxPhotosensors = 4;
  int maxIRSensors = 4;
  int maxLeftMotors = 1;
  int maxRightMotors = 1;

  // runSimulation(ticks, framesPerTick, frames, actionSpread,
  //   minNeurons, maxNeurons, minPhotosensors, maxPhotosensors,
  //   minIRSensors, maxIRSensors, minLeftMotors, maxLeftMotors,
  //   minRightMotors, maxRightMotors);
  sim::runSimulation(0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0);

  return 0;
}
