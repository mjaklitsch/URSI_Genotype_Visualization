#include <iostream>

#ifndef RUNSIMULATION_H_INCLUDED
#define RUNSIMULATION_H_INCLUDED

namespace sim
{
void runSimulation(int ticks, int framesPerTick, int frames, int actionSpread,
  int minN, int maxN, int minP, int maxP, int minIR,
  int maxIR, int minLM, int maxLM, int minRM, int maxRM);
}

#endif
