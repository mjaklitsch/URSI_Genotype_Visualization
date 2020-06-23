class Phenotype{
  
  Cell[] cellArray;
  int numberOfCells;
  
  Phenotype(int tempNumberOfCells){
    numberOfCells = tempNumberOfCells;
    cellArray = new Cell[numberOfCells];
    for(int i = 0; i < numberOfCells; i++){
      Cell nextCell = new Cell();
      cellArray[i] = nextCell;
    }
  }
  
  void drawPhenotype(){
    for(int i = 0; i < numberOfCells; i ++){
      cellArray[i].moveAndMorphCell();
      cellArray[i].setCellSpeedAndGrowth();
      cellArray[i].spawnCell();
    }
  }
  
}
