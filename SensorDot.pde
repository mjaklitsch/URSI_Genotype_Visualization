class SensorDot{
  
  ArrayList<Integer> connections = new ArrayList<Integer>();
  
  float xPos;
  float yPos;
  float size;
  
  SensorDot(float tempxPos, float tempyPos, float tempSize){
    xPos = tempxPos;
    yPos = tempyPos;
    size = tempSize;
  }
  
  void drawSensorDot(){
    fill(0);
    ellipse(xPos, yPos, size, size);
  }
  
}
