#include "Genotype.h"

#ifndef GENERATEGENE_H_INCLUDED
#define GENERATEGENE_H_INCLUDED
// double PI = 2*acos(0.0);
// Genotype Generation Variables
int minDuration;
int maxDuration;
int minDelay;
//int maxDelay = 0; // for testing
int maxDelay;
int minSpeed;
int maxSpeed;
int minGrowthRate;
int maxGrowthRate;

Genotype returnRandomNewGenotype(string cellType);

void printGenotype(Genotype genotype);

#endif
