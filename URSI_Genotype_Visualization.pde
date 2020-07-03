int ticks = 180;
int ticksPerSecond = 6;
int frames = 60;
int currentTick = 0;
int simTime = ticks / ticksPerSecond; // time in seconds
int actionSpread = frames / ticksPerSecond; 

// Processing runs at a designated framerate, we can change that framerate using the framerate() function. 
// By setting the "frames" variable to 60 we know that we have (at most) 60 frames per second and thus a standard for building a timer.
// A tick is a measurement of time in which our simulation progresses by 1 unit.
// By designating a standard "ticksPerSecond" we can find a set number of frames for which the movement of one tick will be spread across, our "actionSpread"
// So if a Cell should move 5 pixels per tick, by spreading this across the actionSpread frames, we get a much smoother animation
// and a much better ability to recognize intersections. (ie. if "actionSpread" = 10, movement per frame is now .5 pixels) This calculation is done in the "Cell" class
// Every frame, "timer" increments in the draw() function, if "timer" is equal to "actionSpread", then "timer" is reset to 0 and "currentTick" is incremented
// While "currentTick" is less than "ticks", the simulation continues, the time spread for generation of Cells is tied to "ticks"
// so increasing simulation time as well as the time spread of the items being simulated is as simple as adjusting the "ticks" variable

//int totalCells = 8;

// Phenotype Generation Variables
int minNeurons = 10;
int minPhotosensors = 2;
int minIRSensors = 2;
int minLeftMotors = 2;
int minRightMotors = 2;

int maxNeurons = 10;
int maxPhotosensors = 6;
int maxIRSensors = 6;
int maxLeftMotors = 3;
int maxRightMotors = 3;

// Genotype Generation Variables
int minDuration = 20;
int maxDuration = 40;
int minDelay = 0;
//int maxDelay = 0; // for testing
int maxDelay = ticks - maxDuration;
int minSpeed = 4;
int maxSpeed = 12;
int minGrowthRate = 3;
int maxGrowthRate = 7;

Phenotype testPhenotype;
SensorArray testSensorArray;

void setup() {
  size(900, 900);
  background(255);
  frameRate(frames);
  testPhenotype = new Phenotype(minNeurons, maxNeurons, minPhotosensors, maxPhotosensors, 
    minIRSensors, maxIRSensors, minLeftMotors, maxLeftMotors, minRightMotors, maxRightMotors);
  testSensorArray = new SensorArray();

  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  pushMatrix();

  translate(width/2, height/2);
  testSensorArray.initializeSensors(5);
  popMatrix();
}

int timer = 0;
int timerOverlap = actionSpread;

void draw() {

  if (currentTick < ticks) {
    if (timer < timerOverlap) {
      timer++;
    } else {
      timer = 0;
      currentTick++;
      //print(currentTick);
      //println();
    }
  } else if (timerOverlap > 0){
    println("***Simulation Complete***");
    println();
    //Robot finalRobot = new Robot(testSensorArray, testPhenotype);
    //finalRobot.printRobot();
    timerOverlap = -1;
  } 

  background(255);
  fill(0);
  //line(0, height/2, width, height/2);
  //line(width/2, 0, width/2, height);
  pushMatrix();

  translate(width/2, height/2);
  testPhenotype.drawPhenotype();
  testPhenotype.recordIntersections();
  testPhenotype.drawConnections();
  testSensorArray.drawSensors();
  testSensorArray.recordIntersections(testPhenotype);
  testSensorArray.drawIntersections(testPhenotype);

  popMatrix();
}

void keyPressed() {
  switch(key) {
  case 'r': // rebuild
    testPhenotype = new Phenotype(minNeurons, maxNeurons, minPhotosensors, maxPhotosensors, 
      minIRSensors, maxIRSensors, minLeftMotors, maxLeftMotors, minRightMotors, maxRightMotors);
    testSensorArray = new SensorArray();
    currentTick = 0;
    timerOverlap = actionSpread;
    timer = 0;
    pushMatrix();
    translate(width/2, height/2);
    testSensorArray.initializeSensors(5);
    popMatrix();
  }
}
