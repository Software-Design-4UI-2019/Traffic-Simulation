class Car {
  int speed;
  float aggression;
  int lane;
  PVector position;
  float completion;
  float speedGoal;
  
  Car(int s, float a, int l, PVector pos) {
    this.speed = s;
    this.aggression = a;
    this.lane = 1;
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
}
