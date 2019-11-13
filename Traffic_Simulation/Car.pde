class Car {
  int speed;
  float aggression;
  int lane;
  PVector position;
  boolean isCrashed;
  
  Car(int s, float a, int l, PVector pos) {
    this.speed = s;
    this.aggression = a;
    this.lane = 1;
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
    
  }
  
  void changeLanes(){
  
  }
}
