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
  while (allCars.size()<18){
  spawnCar();}
  //draws and adds lanes to array of lanes

  L1.addtoLaneArray();
  L2.addtoLaneArray();
  L3.addtoLaneArray();
}

void drawDashes(float x, float y, float offset){
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
  if(paused) {
    pauseButton.setText("Resume");
  }
  else{
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
    fill(allCars.get(i).chooseColour());
    allCars.get(i).drawCar();
    println(allCars.get(i).position);
    if (!paused) {
      allCars.get(i).updateSpeed();
    }
  }
}

void spawnCar() {
  float velx = random(speedlim*0.7,speedlim);
  float vely = 0;
  int aggr = int(random(0.8,1.2));
  Lane carlane = chooseLane();
  float posx = -50;     
  float posy = carlane.startpoint.y+35;
  allCars.add(new Car(new PVector(velx, vely), aggr, carlane, new PVector(posx, posy)));
}

void clearCars() {
  allCars.clear();
  println("All cars cleared.");
}

Lane chooseLane() {
  if ((L1.countCars()>6) && (L2.countCars()>6)) {
    return L3;
  } else if ((L2.countCars()>6) && (L3.countCars()>6)) {
    return L1;
  } else if ((L1.countCars()>6) && (L3.countCars()>6)) {
    return L2;
  } else if (L1.countCars()>6) {
    return lanes.get(int(random(1, 2)));
  } else if (L2.countCars()>6) {
    int[] lanenum = {0, 2};
    return lanes.get(int(lanenum[int(random(0, 1))]));
  } else if (L3.countCars()>6) {
    return lanes.get(int(random(0, 1)));
  } else {
    return lanes.get(int(random(0, 2)));
  }
}
