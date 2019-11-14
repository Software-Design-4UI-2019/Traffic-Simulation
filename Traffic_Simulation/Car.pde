class Car {
  PVector vel;
  float goalSpeed;
  float aggression;
  Lane lane;
  PVector position;
  boolean isCrashed;
  float completion;
  float speed;
  
  Car(PVector s, float a, Lane l, PVector pos) {
    this.vel = s;
    this.aggression = a;
    this.lane = l;
    this.position = pos;
    allCars.add(this);
    this.lane.lanecars.add(this);
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
    rect(position.x,position.y,carl,carw);
  }
  
  //chooses colour of car based on speed
  color chooseColour(){
    float speed = mag(this.vel.x,this.vel.y);
    color carColour = color(0, 0, 0);
    if (speed >= 0 || speed < 20) {
     carColour = color(0, 0, 0);
    }else if (speed >= 20 || speed <= 40) {
         carColour = color(255, 0, 0);
    }
    return carColour;
  }
    
    
  //updates speed of cars
  void updateSpeed(){
    float speed = mag(this.vel.x,this.vel.y);
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
    
  }
  
  void changeLanes(){
  
  }
  
  void update(){
    this.position.add(vel);
    this.completion = this.lane.getCompletionPercent(this);
  }
}
