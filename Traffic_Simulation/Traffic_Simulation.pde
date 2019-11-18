ArrayList<Car> allCars = new ArrayList<Car>();
ArrayList <Lane> lanes = new ArrayList <Lane>();
int speedlim = 80;
float coeffF = 0.05; // coeff of friction
int avgreacspeed = 3;
int baseaggr = 3; //base aggression
int maxAcc = 45; // Max acceleration
int carl = 40;
int carw = 20;
Lane L1 = new Lane(new PVector(0,300),new PVector(1000,300),1);
Lane L2 = new Lane(new PVector(0,350),new PVector(1000,350),2);
Lane L3 = new Lane(new PVector(0,400),new PVector(1000,400),3);
Car C1 = new Car(new PVector(60,0), 4, L1, new PVector(-50,385));

void setup(){
 size(1000,800);
 //creates lanes and car
 

//draws and adds lanes to array of lanes

 L1.addtoLaneArray();
 L2.addtoLaneArray();
 L3.addtoLaneArray();    
 C1.vel = new PVector(60,100);
 fill(C1.chooseColour());
 C1.vel = new PVector(30,0);
 
}

void draw(){
 background(89,239,89);
 fill(105);
 rect(0,300,1000,150);
 //draws car
 L1.drawLane();
 L2.drawLane();
 L3.drawLane();
 allCars.get(0).drawCar();
 C1.updateSpeed();
 println(C1.vel);
}

void spawncar(){
  
}
