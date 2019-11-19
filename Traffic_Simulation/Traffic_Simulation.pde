import g4p_controls.*;

ArrayList<Car> allCars = new ArrayList<Car>();
ArrayList <Lane> lanes = new ArrayList <Lane>();
float speedlim = 40/3.6;
boolean paused = false;
float coeffF = 0.05; // coeff of friction
float avgReacTime = 0.25; // average reaction time, in seconds
int baseAggr = 1; //base aggression
int maxAcc = 6; // Max acceleration
int scaleM = 20; // scale -- how many pixels represent 1 metre
int carl = 2;
int carw = 1;
float spawnRate;

Lane L1 = new Lane(new PVector(0, 300), new PVector(1000, 300), 1);
Lane L2 = new Lane(new PVector(0, 350), new PVector(1000, 350), 2);
Lane L3 = new Lane(new PVector(0, 400), new PVector(1000, 400), 3);

void setup() {
  size(1000, 800);
  frameRate(60);
  createGUI();
  while (allCars.size()<18) {
    spawnCar();
  }
  //draws and adds lanes to array of lanes

  L1.addtoLaneArray();
  L2.addtoLaneArray();
  L3.addtoLaneArray();
}

void drawDashes(float x, float y, float offset) {
  offset = 0;
  for (int i = 0; i < 20; i++) {
    fill(255);
    rect(x+offset, y, 2.5*scaleM, 0.25*scaleM);
    offset += 5*scaleM;
  }
  fill(105);
}

void draw() {
  noStroke();

  //Sets text for pause button
  if (paused) {
    pauseButton.setText("Resume");
  } else {
    pauseButton.setText("Pause");
  }

  background(89, 239, 89);
  fill(105);
  rect(0, 300, 1000, 150);
  speedlim = speedLimitSlider.getValueI()/3.6;
  baseAggr = aggressionSlider.getValueI();
  spawnRate = spawnRateSlider.getValueF();

  //draws lanes
  L1.drawLane();
  L2.drawLane();
  L3.drawLane();
  drawDashes(-40, 400, 100);
  drawDashes(-40, 345, 100);
  //does things for each car
  for (int i = 0; i < allCars.size(); i++) {
    if (allCars.get(i).position.x > 1100){
      allCars.remove(allCars.get(i));}
    stroke(1);
    fill(allCars.get(i).chooseColour());
    allCars.get(i).drawCar();
    if (!paused) {
      allCars.get(i).updateSpeed();
    }
  }
}

void spawnCar() {
  float velx = random(speedlim*0.7, speedlim);
  float vely = 0;
  PVector vel = new PVector(velx, vely);
  int aggr = int(random(0.8, 1.2));
  Lane carlane = chooseLane();
  float posx = -50;     
  float posy = carlane.startpoint.y+35;
  PVector pos =  new PVector(posx, posy);
  //for (Car c : carlane.lanecars) {
  //  if (PVector.dist(c.position, pos)/scaleM < 2) {
  //    println("aaaa");
      //return;
    //}
  //}
  allCars.add(new Car(vel, aggr, carlane, pos));
}

void clearCars() {
  allCars.clear();
  println("All cars cleared.");
}

Lane chooseLane() {
  int min = lanes.get(0).countCars();
  Lane chosenLane = lanes.get(0);
  for (Lane l : lanes) {
    if (l.countCars() <= min) {
      min = l.countCars();
      chosenLane = l;
    }
  }
  return chosenLane;
}
