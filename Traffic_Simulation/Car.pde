class Car {
  int speed;
  float aggression;
  Lane lane;
  PVector position;
  
  
  Car(int s, float a, Lane l, PVector pos) {
    this.speed = s;
    this.aggression = a;
    this.lane = l;
    this.position = pos;
  }
}
