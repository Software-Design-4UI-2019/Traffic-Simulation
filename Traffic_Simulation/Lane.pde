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
    line(startpoint.x, startpoint.y, endpoint.x, endpoint.y);
    line(startpoint.x, startpoint.y+laneWidth, endpoint.x, endpoint.y+laneWidth);
  }

  //counts the number of cars in lane
  int countCars() {
    int numcars = lanecars.size();
    return numcars;
  }

  //calculates how far along the lane a car is
  float getCompletionPercent(Car car) {
    float d1 = PVector.dist(car.position, this.startpoint);
    float d2 = PVector.dist(car.position, this.endpoint);
    return (d1/(d1+d2));
  }
}
