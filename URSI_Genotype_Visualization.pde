final int ticks = 180;
final int ticksPerSecond = 6;
final int frames = 60;
final int simTime = ticks / ticksPerSecond; // time in seconds
final int actionSpread = frames / ticksPerSecond;

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
final int numberOfSensors = 8; // 30 is the max for unknown reasons

// Phenotype Generation Variables
final int minNeurons = 2;
final int minPhotosensors = 2;
final int minIRSensors = 2;
final int minLeftMotors = 1;
final int minRightMotors = 1;

final int maxNeurons = 4;
final int maxPhotosensors = 4;
final int maxIRSensors = 4;
final int maxLeftMotors = 1;
final int maxRightMotors = 1;

// Genotype Generation Variables
final int minDuration = 20;
final int maxDuration = 40;
final int minDelay = 0;
final int maxDelay = 0; // for testing
//final int maxDelay = ticks - maxDuration;
final int minSpeed = 4;
final int maxSpeed = 12;
final int minGrowthRate = 3;
final int maxGrowthRate = 7;

boolean showIndexes = true;

Phenotype testPhenotype;
SensorArray testSensorArray;

void setup() {
  size(900, 900);
  background(255);
  frameRate(frames);
  testPhenotype = new Phenotype(minNeurons, maxNeurons, minPhotosensors, maxPhotosensors, 
    minIRSensors, maxIRSensors, minLeftMotors, maxLeftMotors, minRightMotors, maxRightMotors);
  testSensorArray = new SensorArray();
  
    Cell[] newCellArray = new Cell[8];
    Genotype G0 = new Genotype("N", 0.960873, -1.000000, 4.000000, 32.000000, 5.000000, 0.000000, 27.000000);
    Cell C0 = new Cell(G0, 0);
    newCellArray[0] = C0;
    Genotype G1 = new Genotype("P", 3.522930, 4.000000, 6.000000, 28.000000, 8.000000, 0.000000, 39.000000);
    Cell C1 = new Cell(G1, 1);
    newCellArray[1] = C1;
    Genotype G2 = new Genotype("P", 1.246024, 3.000000, 5.000000, 33.000000, 5.000000, 0.000000, 30.000000);
    Cell C2 = new Cell(G2, 2);
    newCellArray[2] = C2;
    Genotype G3 = new Genotype("P", 5.344616, -3.000000, 3.000000, 36.000000, 10.000000, 0.000000, 25.000000);
    Cell C3 = new Cell(G3, 3);
    newCellArray[3] = C3;
    Genotype G4 = new Genotype("R", 4.476335, 2.000000, 5.000000, 37.000000, 7.000000, 0.000000, 22.000000);
    Cell C4 = new Cell(G4, 4);
    newCellArray[4] = C4;
    Genotype G5 = new Genotype("R", 6.245012, -1.000000, 3.000000, 39.000000, 5.000000, 0.000000, 38.000000);
    Cell C5 = new Cell(G5, 5);
    newCellArray[5] = C5;
    Genotype G6 = new Genotype("LM", 2.140894, -5.000000, 3.000000, 27.000000, 4.000000, 0.000000, 33.000000);
    Cell C6 = new Cell(G6, 6);
    newCellArray[6] = C6;
    Genotype G7 = new Genotype("RM", 0.013736, -2.000000, 3.000000, 22.000000, 11.000000, 0.000000, 26.000000);
    Cell C7 = new Cell(G7, 7);
    newCellArray[7] = C7;

    testPhenotype.cellArray = newCellArray;
    testPhenotype.numberOfCells = 8;

  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  //pushMatrix();

  //translate(width/2, height/2);
  testSensorArray.initializeSensors(5);
  //popMatrix();
}

int timer = 0;
int currentTick = 0;
int timerOverlap = actionSpread;

//float testTheta = 0;
//float testIncrement = .01;

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
  } else if (timerOverlap > 0) {
    println("***Simulation Complete***");
    println();
    Robot finalRobot = new Robot(testSensorArray, testPhenotype);
    finalRobot.printRobot();
    timerOverlap = -1;
  } 

  background(255);
  text("Press 'r' to rebuild, press 'i' to show or hide cell indexes", 50, 50);
  fill(0);
  //line(0, height/2, width, height/2);
  //line(width/2, 0, width/2, height);
  //pushMatrix();

  //translate(width/2, height/2);
  //line(0,0,getxCoordinateOfPolygonAtTheta(testTheta), getyCoordinateOfPolygonAtTheta(testTheta));

  //testTheta += testIncrement;

  testPhenotype.drawPhenotype(); // draws circles
  testPhenotype.recordIntersections();
  testPhenotype.drawConnections();
  testSensorArray.drawSensors();
  testSensorArray.recordIntersections(testPhenotype);
  testSensorArray.drawIntersections(testPhenotype);


  //popMatrix();
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
    break;
  case 'i':
    showIndexes = !showIndexes;
    break;
  }
}
