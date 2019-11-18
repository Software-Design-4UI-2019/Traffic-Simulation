class Car {
  PVector vel;
  float goalSpeed;
  float aggression;
  Lane lane;
  PVector position;
  boolean isCrashed;
  float completion;
  
  Car(PVector v, float a, Lane l, PVector pos) {
    this.vel = v;
    this.aggression = a;
    this.lane = l;
    this.position = pos;
    allCars.add(this);
    this.lane.lanecars.add(this);
    float speed = mag(this.vel.x,this.vel.y);
  }

  //checks for crashes
  void crashCheck() {
    for (Car c: allCars) {
      if (PVector.dist(c.position , this.position)< 20){
        this.isCrashed = true;
      }
    }
  }
    
  void drawCar(){
    fill(chooseColour());
    rect(position.x-carl,position.y-carw,carl,carw);
    println(speed);
  }
  
  //chooses colour of car based on speed
  color chooseColour(){
    colorMode(HSB, 255);
    color carColour = color(30, 150, 30);
    if (this.speed >= 0 || this.speed < 20) {
     carColour = color(0, 255, 255);
    }else if (this.speed >= 20 || this.speed < 40) {
         carColour = color(40, 255, 255);
    }else if (this.speed >= 40 || this.speed < 60) {
         carColour = color(80, 255, 255);
    }else if (this.speed >= 60 || this.speed < 80) {
         carColour = color(120, 255, 255);
    }else if (this.speed >= 80 || this.speed < 100) {
         carColour = color(160, 255, 255);
    }else if (this.speed >= 100 || this.speed < 120) {
         carColour = color(200, 255, 255);
     }
    return carColour;
  }
    
    
  //updates speed of cars
  void updateSpeed(){

    if (this.isCrashed){
      this.goalSpeed = 0;
    }
    Car nextCar = null;
    for (Car car : this.lane.lanecars){
      if (nextCar == null){
        nextCar = car;
      }
      else if ((car.completion > this.completion && car.completion < nextCar.completion)){
        nextCar = car;
      }
    }
    if (nextCar == null){
      this.goalSpeed = speedlim * this.aggression;
    }
    this.position.x += this.vel.x;
    this.position.y += this.vel.y;
    
  }
  
  
  void changeLanes(String d){
    Lane currLane = this.lane;
    }
      
  void checkSurrounding(){
    PVector A = new PVector(this.position.x-40,this.position.y+40);
    PVector B = new PVector(this.position.x-40,this.position.y-40);
    PVector C = new PVector(this.position.x+40,this.position.y+40);
    PVector D = new PVector(this.position.x-40,this.position.y-40);
    //check what lane we're in
    //leftmost lane
    if (this.lane == lanes.get(0)){
      if (dist(A.x,A.y,this.position.x,this.position.y) > 0){
      }
      
    }
    //middle lane
    else if (this.lane == lanes.get(1)){
    }
    //rightmost lane
    else{
    }
  }
    
  
  void updateCompletion(){
    this.position.add(vel);
    this.completion = this.lane.getCompletionPercent(this);
  }}
