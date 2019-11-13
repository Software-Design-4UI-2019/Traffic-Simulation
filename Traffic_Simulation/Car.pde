class Car {
  float speed;
  float goalSpeed;
  float aggression;
  Lane lane;
  PVector position;
  boolean isCrashed;
  
  Car(int s, float a, Lane l, PVector pos) {
    this.speed = s;
    this.aggression = a;
    this.lane = l;
    this.position = pos;
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
  
  void chooseColour(){
     
  }
  
  void updateSpeed(){
    if (this.isCrashed){
      this.goalSpeed = 0;
    }
    
    
  }
  
  void changeLanes(){
  
  }
}
