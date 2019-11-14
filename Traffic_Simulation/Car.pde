class Car {
  PVector vel;
  float goalSpeed;
  float aggression;
  Lane lane;
  PVector position;
  boolean isCrashed;
  
  Car(PVector s, float a, Lane l, PVector pos) {
    this.vel = s;
    this.aggression = a;
    this.lane = l;
    this.position = pos;
    allCars.add(this);
    this.lane.lanecars.add(this);
  }

  
  
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
    
    
  
  void updateSpeed(){
    float speed = mag(this.vel.x,this.vel.y);
    if (this.isCrashed){
      this.goalSpeed = 0;
    }
    
    
  }
  
  void changeLanes(){
  
  }
  
  void update(){
    this.position.add(vel);}
}
