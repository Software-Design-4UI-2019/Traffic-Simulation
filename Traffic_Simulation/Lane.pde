class Lane{
  PVector startpoint;
  PVector endpoint;
  int laneID;
  ArrayList <Car> lanecars;
  int laneWidth = 50;
  
  Lane(PVector s, PVector e, int i){
    this.startpoint =  s;
    this.endpoint = e;
    this.laneID = i;
    this.lanecars = new ArrayList <Car>();
    lanes.add(this);
  }
  
  //draws lanes
  void drawLane(){
    line(startpoint.x,startpoint.y,endpoint.x,endpoint.y);
    line(startpoint.x,startpoint.y+laneWidth,endpoint.x,endpoint.y+laneWidth);}
  
  //counts cars in lane
  int countCars(){
    int numcars = lanecars.size();
    return numcars;}
  
  void addtoLaneArray(){
    lanes.add(this);
  }
  
  //calculates how far along the lane a car is
  float getCompletionPercent(Car car){
    float d1 = PVector.dist(car.position, this.startpoint);
    float d2 = PVector.dist(car.position, this.endpoint);
    return (d1/(d1+d2));
  }

}
