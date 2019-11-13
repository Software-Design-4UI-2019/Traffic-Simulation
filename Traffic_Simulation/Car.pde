class Car {
  int speed;
  float aggression;
  int lane;
  PVector position;
  
  
  Car(int s, float a, int l, PVector pos) {
    this.speed = s;
    this.aggression = a;
    this.lane = 1;
    this.position = pos;
  }
  
  boolean isCrashed() {
    for (Car c: this.lane.lanecars) {
      if (c.position =  this.position){
        return true
      }else{
        return false
    }
   void drawcar(){
    rect(position.x,position.y,position.x+carl,position.y+carw);
  }
  
  void updatespeed(){
    
  }
  
  void changelanes(){
  
  }
}

    
