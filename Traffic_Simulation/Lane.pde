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
    rect(0, startpoint.y+65, width, laneWidth+25);
    println(startpoint.y);
  }

  //counts the number of cars in lane
  int countCars() {
    int numcars = lanecars.size();
    return numcars;
  }
}
