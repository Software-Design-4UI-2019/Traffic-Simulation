class Car {
  PVector position;
  PVector vel;
  float speed;
  float completion; //how far along the lane the car is
  Lane lane; //what lane the car is in
  Lane switchingLane;
  boolean isCrashed;
  float aggression;
  color carColour;
  Car(PVector v, float a, Lane l, PVector pos) {
    this.vel = v;
    this.aggression = a;
    this.lane = l;
    this.switchingLane = l;
    this.position = pos;

    //adds car to allCars array and to an array of cars within each lane
    allCars.add(this);
    this.lane.lanecars.add(this);

    //creates a scalar value based on the car's velocity
    speed = mag(this.vel.x, this.vel.y);
  }


  void superUpdate() {
    //information variables:
    this.updateCompletion();
    this.speed = this.vel.mag();

    //logic:
    if (this.switchingLane == this.lane){// If this is not currently switching lanes
      if (this.laneChangeCheck() != this.lane){// if there is a better lane to switch to
        checkSurrounding(this.laneChangeCheck());
      }
    }
    
    this.doLaneChange();

    this.updateSpeed();

    //physics:
    this.crashCheck();
    this.position.x += this.vel.x * scaleM / frameRate;
    this.position.y += this.vel.y * scaleM / frameRate;

    //draw:
    this.drawCar();
    
    this.checkDeletion();
  }

  void checkDeletion() {
    if (this.position.x > width + 2*scaleM) {
      allCars.remove(this);
      this.lane.lanecars.remove(this);
      //println(this.position,"deleted");
    }
  }

  //checks for crashes
  void crashCheck() { //TO DO: CRASH PHYSICS
    for (Car c : allCars) {
      if (abs(c.position.x-this.position.x) / scaleM < 2 && abs(c.position.y -this.position.y)/scaleM < 1 && c != this) {
        //println("Crashed: " + PVector.dist(c.position, this.position));
        this.isCrashed = true;
      }
    }
  }
  
  void doLaneChange(){
    if (this.switchingLane != this.lane){ // if it has to switch lanes
      if (this.vel.heading() == 0){ // if this has not turned yet
         this.switchingLane.lanecars.add(this); // while a car is switching lanes, it is in both lanes.
        int d = 0; // direction of the lane.
        if (this.switchingLane.startpoint.y > this.lane.startpoint.y) { // the target lane is below the car
          d = 1;
        } else if (this.switchingLane.startpoint.y < this.lane.startpoint.y) { // the target lane is above the car
          d = -1;
        }
        this.vel.rotate(PI/6 * d);
      }
      else if(abs(this.switchingLane.startpoint.y - this.position.y)<= abs(this.vel.y)){ // if the difference of the y positions is equal or less than velocity
        this.position.y = this.switchingLane.startpoint.y; //align y value
        this.vel.rotate(-this.vel.heading()); //rotate back to 0
        this.lane.lanecars.remove(this); // lane array stuff
        this.lane = this.switchingLane;
      }
    }
  }

  //draws each car
  void drawCar() {
    this.chooseColour();
    fill(carColour);
    rect(position.x - carl * scaleM, position.y - carw * scaleM, carl * scaleM, carw * scaleM);//draw the car
  }

  //chooses colour of car based on speed
  color chooseColour() {
    this.carColour = color(int(this.speed * (255/100)), 255, 255);
    return carColour;
  }

  //updates speed of cars (thus driving the animation)
  void updateSpeed() {
    if (this.isCrashed) {
      this.vel.setMag(max( this.speed - coeffF, 0));
    }
    else{
      
      ArrayList<Car> carsAhead = new ArrayList<Car>();
      for (Car car: this.lane.lanecars){
        if (car.completion > this.completion){
          carsAhead.add(car);
        }
      }
      float minCompletion = 2;
      Car nextCar = null;
      for (Car car : carsAhead) {
        if ((car.completion < minCompletion)) {
          nextCar = car;
          minCompletion = nextCar.completion;
        }
      }
      if (nextCar==null) {
        this.vel.setMag(min(speedlim * this.aggression, this.speed + maxAcc/frameRate));
      } else {
        float currDist = PVector.dist(this.position, nextCar.position); // literal distance between this car and the next
        float reacDist = pow(this.speed*scaleM, 2) / (coeffF*20); // distance required to stop
        //println(currDist,reacDist,currDist/reacDist);
        
        if (currDist>reacDist) { 
          this.vel.setMag(min(this.speed*currDist/(reacDist), speedlim * this.aggression, this.speed + maxAcc/frameRate)); // slow down or speed up the car according to the distance of the next car in the lane.
        } else {
          this.vel.setMag(max(this.speed*currDist/(reacDist), this.speed - coeffF, 0));
        }
      }
    }
  }

  //checks the surrounding of a car for lane changes
  Lane laneChangeCheck() {  //Check whether to change lanes, and also what direction and distance to go.'
    ArrayList<Integer> carsAhead = new ArrayList<Integer>();
    Lane bestLane = lanes.get(int(random(lanes.size())));// find the lane with the least cars in front of this car
    int min = -1;
    for (Lane l :lanes){
      int count = 0;
      for (Car c: l.lanecars){
        if (c != this && c.completion > this.completion){
          count += 1;
        }
      }
      if (min == -1){
        min = count;
      }
      else if (min < count){
        min = count;
      }
      carsAhead.add(count);
    }
    bestLane = lanes.get(carsAhead.indexOf(min));
    
    //println(lanes.indexOf(bestLane),lanes.indexOf(this.lane));
    // To get to the best lane, you must first switch to the lane that is adjacent to you in the direction you want to go.
    int d = 0;// is the target lane up or down?
    if (bestLane.startpoint.y > this.lane.startpoint.y) { // the target lane is below the car
      //println("down");
      d = 1;
    } else if (bestLane.startpoint.y < this.lane.startpoint.y) { // the target lane is above the car
      //println("up");
      d = -1;
    }
    int index = lanes.indexOf(this.lane)+d; 
    if (random(1) < couldChangeLanes/10){//have a chance to change lanes
      return lanes.get(index);
    }
    else{
      return this.lane;
    }
  }

  //checks the surrounding of a car for lane changes
  void checkSurrounding(Lane l) {
    int d = 0; // direction of the lane.
    if (l.startpoint.y > this.lane.startpoint.y) { // the target lane is below the car
      d = 1;
    } else if (l.startpoint.y < this.lane.startpoint.y) { // the target lane is above the car
      d = -1;
    }
    PVector A = new PVector(this.position.x- 2*scaleM, this.position.y + 50 * d); //check a rectangular area to see if you can switch into that lane.
    PVector B = new PVector(this.position.x+ 2*scaleM, this.position.y - 2*scaleM * d);
    boolean commit = true;
    for (Car c : l.lanecars) {
      if (A.x < c.position.x 
        && c.position.x < B.x 
        && min(A.y, B.y) < c.position.y 
        && c.position.y < max(A.y, B.y)) { // if c lies inside the rectangle
        commit = false; //don't turn
      }
    }
    if (commit) {
      this.switchingLane = l;
    }
    else{
      this.switchingLane = this.lane;
    }
  }


  void updateCompletion() {
    this.completion = this.position.x/width;
  }
}
