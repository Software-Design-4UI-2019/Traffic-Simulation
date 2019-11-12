class Car {
  int speed;
  float aggression;
  Lane lane;
  PVector position;
  float completion;
  float speedGoal;
  
  Car(int s, float a, Lane l, PVector pos) {
    this.speed = s;
    this.aggression = a;
    this.lane = l;
    this.position = pos;
  }
}

void stoppingDistCheck(){
  Car car;
  
  for (Car c: this.lane.lanecars){ //find the car right in front of this one.
    if (c.completion > this.completion){
      if (c.completion<car.completion || car == null){
        car = c;
      }
    }
  }
  
  if (car == null){
    this.speedGoal = speedLimit * this.aggression;
  
  }
  
  void drawcar(){
    rect(position.x,position.y,position.x+carl,position.y+carw);
  }
  
  void updatespeed(){
  }
}

