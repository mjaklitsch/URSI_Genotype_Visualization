#include "RunSimulation.h"
#include "Phenotype.h"
#include "SensorArray.h"
#include <iostream>

using namespace sim;

sim::runSimulation(int ticks, int framesPerTick, int frames, int actionSpread,
  int minN, int maxN, int minP, int maxP, int minIR,
  int maxIR, int minLM, int maxLM, int minRM, int maxRM){

  srand((unsigned) time(0));
  int timer = 0;
  // int currentTick = 0;
  int timerOverlap = actionSpread;

  Phenotype testPhenotype = new Phenotype(minN, maxN, minP, maxP,
    minIR, maxIR, minLM, maxLM, minRM, maxRM);
  SensorArray testSensorArray = new SensorArray();


  testSensorArray->initializeSensors();

  for(int currentTick = 0; currentTick < ticks; currentTick++){

    for(int currentFrame = 0; currentFrame < frames; currentFrame++){

      testPhenotype->moveCells();
      testPhenotype->recordIntersections();
      testPhenotype->updateAllConnectionPositions();
      testSensorArray->recordIntersections(testPhenotype);

    }

  }

  Robot finalRobot = new Robot(testSensorArray, testPhenotype);
  finalRobot->printRobot();
}
