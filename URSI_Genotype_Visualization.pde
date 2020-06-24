int ticks = 180;
int ticksPerSecond = 6;
int frames = 60;
int currentTick = 0;
int simTime = ticks / ticksPerSecond; // time in seconds
int actionSpread = frames / ticksPerSecond; 

int totalCells = 8;

// At least this amount of the cell type will be spawned, TODO: needs to be changed to exactly this number spawn(maybe?)
int requiredNeurons = 0;
int requiredPhotosensors = 0;
int requiredIRSensors = 0;
int requiredLeftMotors = 0;
int requiredRightMotors = 0;

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
  print("Test " + getIndexOfClosestSensorDotToAngle(301));
  size(1000, 1000);
  background(255);
  frameRate(frames);
  testPhenotype = new Phenotype(totalCells, requiredNeurons, requiredPhotosensors, requiredIRSensors, requiredLeftMotors, requiredRightMotors);
  testSensorArray = new SensorArray();

  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  pushMatrix();

  translate(width/2, height/2);
  testSensorArray.initializeSensors(5);
  popMatrix();
}

int timer = 0;

void draw() {

  if (currentTick < ticks) {
    if (timer < actionSpread) {
      timer++;
    } else {
      timer = 0;
      currentTick++;
      //print(currentTick);
      //println();
    }
  } else {
    print("***Simulation Complete***");
    noLoop();
  }

  background(255);
  fill(0);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
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
