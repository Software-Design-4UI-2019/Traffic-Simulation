class Lane{
  PVector startpoint;
  PVector endpoint;
  int laneid;
  ArrayList <Car> lanecars;
  int lanewidth = 50;
  
 Lane(PVector s, PVector e, int i){
  this.startpoint =  s;
  this.endpoint = e;
  this.laneid = i;
  this.lanecars = new ArrayList <Car>();}

void drawLane(){
  line(startpoint.x,startpoint.y,endpoint.x,endpoint.y);
  line(startpoint.x,startpoint.y+lanewidth,endpoint.x,endpoint.y+lanewidth);}
  
int countCars(){
  int numcars = lanecars.size();
  return numcars;}
  
