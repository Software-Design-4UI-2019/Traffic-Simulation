class Lane {
  PVector startpoint;
  PVector endpoint;
  int laneID; //a string used to identify a lane
  ArrayList <Car> lanecars;
  int laneWidth = 50;

  Lane(PVector s, PVector e, int i) {
    this.startpoint =  s;
    this.endpoint = e;
    this.laneID = i;
    this.lanecars = new ArrayList <Car>();
    lanes.add(this); //adds lane to a global array of lanes
  }

  //draws lane
  void drawLane() {
    fill(105);
    rect(0, startpoint.y-laneWidth/2, width, laneWidth);
    //println(startpoint.y);
    int offset = 0;
    for (int i = 0; i < width/7.5*scaleM; i++) {
      fill(255);
      rect(this.startpoint.x+offset, this.startpoint.y, 2.5*scaleM, 0.25*scaleM);
      offset += 5*scaleM;
    }
  }
  
  
  //counts the number of cars in lane
  int countCars() {
    int numcars = lanecars.size();
    return numcars;
  }
}
