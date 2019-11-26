//imports GUI and creates global variables
import g4p_controls.*;
ArrayList<Car> allCars = new ArrayList<Car>();
ArrayList <Lane> lanes = new ArrayList <Lane>();
float speedlim = 40/3.6;
boolean paused = false;
float coeffF = 0.7; // coefficient of friction
float avgReacTime = 0.25; // average reaction time, in seconds
float baseAggr; //base aggression global
int maxAcc = 6; // Max acceleration
int scaleM = 20; // scale -- how many pixels represent 1 metre
int carl = 2; // length of a car
int carw = 1; // width of a car
float spawnRate; // spawn rate global
float timepassed; //time passed in program global
float couldChangeLanes = 20;
int numLanes = 3;

//creates car lanes
//Lane L1 = new Lane(new PVector(0, 400), new PVector(width, 400), 1);
//Lane L2 = new Lane(new PVector(0, 450), new PVector(width, 450), 2);
//Lane L3 = new Lane(new PVector(0, 500), new PVector(width, 500), 3);

void setup() {
  size(1200, 960);
  frameRate(60);
  createGUI();
  colorMode(HSB, 255);

  }

//draws dashes that separate lanes from each other
void drawDashes(float x, float y, float offset) {
  offset = 0;
  //offsets lines to create "dash" effect
  for (int i = 0; i < 20; i++) {
    fill(255);
    rect(x+offset, y, 2.5*scaleM, 0.25*scaleM);
    offset += 5*scaleM;
  }
  fill(105);
}

void draw() {
  //calculates the time passed since the program began running
  timepassed = millis();
  noStroke();

  //Sets text for pause button
  if (paused) {
    pauseButton.setText("Resume");
  } else {
    pauseButton.setText("Pause");
  }

  //creates background and grass
  background(89, 239, 89);
  fill(89, 70, 89);
  spawnLane();
  //fetches values from sliders
  speedlim = speedLimitSlider.getValueI()/3.6;
  baseAggr = aggressionSlider.getValueI();
  spawnRate = getSpawnRate()*3;
  maxAcc = speedChangeRateSlider.getValueI();
  couldChangeLanes = couldChangeLanesSlider.getValueI()*0.01;

  //continuously spawns cars
  if (timepassed%spawnRate == 0) {
    spawnCar();
  }

  //does things for each car
  for (int i = 0; i < allCars.size(); i++) {
    //pauses animation if user clicks "pause" button
    if (paused) {
      allCars.get(i).drawCar();
    }
    else{
      allCars.get(i).superUpdate();
      if (allCars.get(i).position.x > width+50) {
        allCars.remove(allCars.get(i));
      }
    }
  }
}

void spawnLane(){
  int numLanes = int(numberOfLanes.getText());
  if (numLanes != lanes.size()){
    lanes.clear();
    allCars.clear();
    float laneheight = ((height/2) - (numLanes*50/2));
    for (int i = 0; i < numLanes; i++){
      PVector startv = new PVector(0,laneheight);
      PVector endv = new PVector(width, laneheight);
      lanes.add(new Lane(startv, endv, i+1));
      //won't properly draw lane
      // lanes.get(i).drawLane();
      if (i != 0 & i != lanes.size()-1){
        drawDashes(-40,laneheight+50, 100);
      }
      laneheight += 50;
    }
  
  }
  
}

//spawns a car using randomly generated velocity and lane values and adds it to the allCars array
void spawnCar() {
  
  float velx = random(speedlim*0.7, speedlim);
  float vely = 0;
  PVector vel = new PVector(velx, vely);
  Lane carlane = chooseLane();
  float posx = -50;     
  float posy = carlane.startpoint.y+35;
  PVector pos =  new PVector(posx, posy);
  allCars.add(new Car(vel, baseAggr, carlane, pos));
}

//clears all cars on screen
void clearCars() {
  allCars.clear();
}

//selects a lane for a new car to appear in (this function is called when the spawnCar function is called
Lane chooseLane() {
  //sees which lane has the least amount of cars within it
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

//reassigns spawn rate based on what user selects on the slider (the spawn rate variable is used with the timepassed variable
//assume n = spawnrate; a new car spawns every n seconds
//therefore, we can't use the user chosen spawn rate as a higher spawn rate means cars spawn less frequently! it must be reassigned
float getSpawnRate() {
  float x;
  switch (spawnRateSlider.getValueI()) {
  case 5:
    x = 1;
    break;
  case 4:
    x = 2;
    break;
  case 3:
    x = 3;
    break;
  case 2:
    x = 4;
    break;
  default:
    x = 5;
    break;
  }
  return x;
}
