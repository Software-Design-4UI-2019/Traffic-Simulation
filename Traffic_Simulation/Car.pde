class Car {
  PVector position;
  PVector vel;
  float speed;
  float completion; //how far along the lane the car is
  Lane lane; //what lane the car is in
  boolean isCrashed;
  float aggression;
  float reacTime;//reaction time
  color carColour;
  Car(PVector v, float a, Lane l, PVector pos) {
    this.vel = v;
    this.aggression = a;
    this.lane = l;
    this.position = pos;
    this.reacTime = avgReacTime + randomGaussian() * 0.1;

    //adds car to allCars array and to an array of cars within each lane
    allCars.add(this);
    this.lane.lanecars.add(this);

    //creates a scalar value based on the car's velocity
    speed = mag(this.vel.x, this.vel.y);
  }

  
  void superUpdate(){
    //information variables:
    
    this.updateCompletion();
    this.speed = this.vel.mag();
    
    //logic:
    this.laneChangeCheck();
    this.updateSpeed();
    
    //physics:
    this.crashCheck();
    this.position.x += this.vel.x * scaleM / frameRate;
    this.position.y += this.vel.y * scaleM / frameRate;
    
    this.drawCar();
  
  }
  //checks for crashes
  void crashCheck() { //TO DO: CRASH PHYSICS
    for (Car c : allCars) {
      if (PVector.dist(c.position, this.position) / scaleM < 2 && c != this) {
        println(PVector.dist(c.position, this.position));
        this.isCrashed = true;
      }
    }
  }

  //draws each car
  void drawCar() {
    this.chooseColour();
    fill(carColour);
    rect(position.x - carl * scaleM, position.y - carw * scaleM, carl * scaleM, carw * scaleM);
  }

  //chooses colour of car based on speed
  color chooseColour() {
    this.carColour = color(int(this.speed * (255/100)), 255, 255);
    return carColour;
  }

  //updates speed of cars (thus driving the animation)
  void updateSpeed() {
    if (this.isCrashed) {
      this.vel.setMag(max( this.speed - coeffF * 9.8, 0));
    }
    Car nextCar = null;
    for (Car car : this.lane.lanecars) {
      if (nextCar == null) {
        nextCar = car;
      } else if ((car.completion > this.completion && car.completion < nextCar.completion)) {
        nextCar = car;
      }
    }
    if (nextCar == this) {
      this.vel.setMag(min(speedlim * this.aggression, this.speed + maxAcc));
    } else {
      float currDist = PVector.dist(this.position, nextCar.position)/scaleM;
      float reacDist = this.reacTime * this.speed/scaleM + pow(this.speed/scaleM, 2) / (2*coeffF*9.8) ;
      if (currDist/reacDist > 1) {
        this.vel.setMag(min(this.speed*currDist/reacDist, speedlim * this.aggression, this.speed + maxAcc));
      } else {
        this.vel.setMag(max(this.speed*currDist/reacDist, this.speed - coeffF * 9.8, 0));
      }
    }
  }

  //changes the lane of a car
  void changeLanes(String d) {
    Lane currLane = this.lane;
    //Lane newLane = ;
  }

  //MUST FINISH
  //checks the surrounding of a car for lane changes
  void laneChangeCheck() {  //Check whether to change lanes, and also what direction and distance to go.
    //checkSurrounding();
  }
  
  //checks the surrounding of a car for lane changes
  void checkSurrounding() {
    PVector A = new PVector(this.position.x-40, this.position.y+40);
    PVector B = new PVector(this.position.x-40, this.position.y-40);
    PVector C = new PVector(this.position.x+40, this.position.y+40);
    PVector D = new PVector(this.position.x-40, this.position.y-40);
    //check what lane we're in
    //leftmost lane
    if (this.lane == lanes.get(0)) {
      if (dist(A.x, A.y, this.position.x, this.position.y) > 0) {
      }
    }
    //middle lane
    else if (this.lane == lanes.get(1)) {
    }
    //rightmost lane
    else {
    }
  }


  void updateCompletion() {
    this.position.add(vel);
    this.completion = this.lane.getCompletionPercent(this);
  }
}
