int ticks = 180;
int ticksPerSecond = 6;
int frames = 60;
int currentTick = 0;
int simTime = ticks / ticksPerSecond; // time in seconds
int actionSpread = frames / ticksPerSecond; 

Phenotype testPhenotype = new Phenotype(12);

void setup() {
  size(1000, 1000);
  background(255);
  frameRate(frames);
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
    print("done");
    noLoop();
  }

  background(255);
  fill(0);

  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  pushMatrix();

  translate(width/2, height/2);
  plotHexadecagon(5);
  testPhenotype.drawPhenotype();

  popMatrix();
}
