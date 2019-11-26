class Car {
  PVector position;
  PVector vel;
  float speed;
  float completion; //how far along the lane the car is
  Lane lane; //what lane the car is in
  Lane switchingLane;
  boolean isCrashed;
  float aggression;
  float reacTime;//reaction time
  color carColour;
  Car(PVector v, float a, Lane l, PVector pos) {
    this.vel = v;
    this.aggression = a;
    this.lane = l;
    this.switchingLane = l;
    this.position = pos;
    this.reacTime = avgReacTime + randomGaussian() * 0.1;

    //adds car to allCars array and to an array of cars within each lane
    allCars.add(this);
    this.lane.lanecars.add(this);

    //creates a scalar value based on the car's velocity
    speed = mag(this.vel.x, this.vel.y);
  }


  void superUpdate() {
    //information variables:
    this.checkDeletion();
    this.updateCompletion();
    this.speed = this.vel.mag();

    //logic:
    //if (this.laneChangeCheck() != this.lane && this.switchingLane == this.lane){// if there is a better lane to switch to, and it is not currently switching lanes
    //    checkSurrounding(this.laneChangeCheck());
    //}
    //this.doLaneChange();

    this.updateSpeed();

    //physics:
    this.crashCheck();
    this.position.x += this.vel.x * scaleM / frameRate;
    this.position.y += this.vel.y * scaleM / frameRate;

    //draw:
    this.drawCar();
  }

  void checkDeletion() {
    if (this.position.x > width + 2*scaleM) {
      allCars.remove(this);
      this.lane.lanecars.remove(this);
      println(this.position, "deleted");
    }
  }

  //checks for crashes
  void crashCheck() { //TO DO: CRASH PHYSICS
    for (Car c : allCars) {
      if (PVector.dist(c.position, this.position) / scaleM < 2 && c != this) {
        println("Crashed: " + PVector.dist(c.position, this.position));
        this.isCrashed = true;
      }
    }
  }

  void doLaneChange() {
    if (this.switchingLane != this.lane) { // if it has to switch lanes
      if (this.vel.heading() == 0) { // if this has not turned yet
        int d = 0; // direction of the lane.
        if (this.switchingLane.startpoint.y - this.position.y > 25) { // the target lane is below the car
          d = 1;
        } else if (this.switchingLane.startpoint.y - this.position.y < -25) { // the target lane is above the car
          d = -1;
        }
        this.vel.rotate(PI/3 * d);
      } else {
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
      println(this.vel, "crashed");
      this.vel.setMag(max( this.speed - coeffF * 9.8, 0));
      println(this.vel, "crashed2");
    } else {
      Car nextCar = this;
      for (Car car : this.lane.lanecars) {
        if ((car.completion > this.completion && car.completion < nextCar.completion)) {
          nextCar = car;
        }
      }
      if (nextCar==this) {
        this.vel.setMag(min(speedlim * this.aggression, this.speed + maxAcc));
      } else {
        float currDist = PVector.dist(this.position, nextCar.position)/scaleM - 2*scaleM;
        float reacDist = this.reacTime * this.speed/scaleM + pow(this.speed/scaleM, 2) / (2*coeffF*9.8) -2*scaleM;
        if (currDist/reacDist > 1) {
          this.vel.setMag(min(this.speed*currDist/reacDist, speedlim * this.aggression, this.speed + maxAcc));
        } else {
          this.vel.setMag(max(this.speed*currDist/reacDist, this.speed - coeffF * 9.8, 0));
        }
      }
    }
  }

  //checks the surrounding of a car for lane changes
  Lane laneChangeCheck() {  //Check whether to change lanes, and also what direction and distance to go.
    int[] carsAhead = new int[lanes.size()];
    Lane bestLane = this.lane;
    for (int i = 0; i<lanes.size(); i++) {
      Lane l = lanes.get(i);
      int count = 0;
      for (Car c : l.lanecars) {
        if (c != this && c.completion >= this.completion) {
          count += 1;
        }
      }
      carsAhead[i] = count;
      if (count > max(carsAhead)) {
        bestLane = l;
      }
    }
    // To get to the best lane, you must first switch to the lane that is adjacent to you in the direction you want to go.
    int d = 0;// is the target lane up or down?

    if (bestLane.startpoint.y - this.position.y > 25) { // the target lane is below the car
      d = 1;
    } else if (bestLane.startpoint.y - this.position.y < -25) { // the target lane is above the car
      d = -1;
    }
    return (lanes.get(lanes.indexOf(this.lane)+d)); // return the target lane.
  }

  //checks the surrounding of a car for lane changes
  void checkSurrounding(Lane l) {
    int d = 0; // direction of the lane.
    if (l.startpoint.y - this.position.y > 25) { // the target lane is below the car
      d = 1;
    } else if (l.startpoint.y - this.position.y < -25) { // the target lane is above the car
      d = -1;
    }
    PVector A = new PVector(this.position.x-2*scaleM, this.position.y + 50 * d); //check a rectangular area to see if you can switch into that lane.
    PVector B = new PVector(this.position.x+scaleM, this.position.y);
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
  }


  void updateCompletion() {
    this.completion = this.position.x/width;
    //fix this this.completion = this.lane.getCompletionPercent(this);
  }
}
