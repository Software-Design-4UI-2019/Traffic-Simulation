ArrayList<Car> allCars = new ArrayList<Car>();
ArrayList <Lane> lanes = new ArrayList <Lane>();
int speedlim = 80;
float coeffF = 0.05;
int avgreacspeed = 3;
int baseaggr = 3;
int maxAcc = 45; // Max acceleration
int carl = 40;
int carw = 20;

void setup(){
 size(1000,800);
 Lane L1 = new Lane(new PVector(0,300),new PVector(1000,300),1);
 Lane L2 = new Lane(new PVector(0,350),new PVector(1000,350),2);
 Lane L3 = new Lane(new PVector(0,400),new PVector(1000,400),3);
 Car C1 = new Car(60, 4, L1, new PVector(400,415));

 L1.drawLane();
 L2.drawLane();
 L3.drawLane();
 L1.addtoLaneArray();
 L2.addtoLaneArray();
 L3.addtoLaneArray();    
 fill(C1.chooseColour());
 C1.speed = 30;

 
 
}

void draw(){
 allCars.get(0).drawCar();
}

void spawncar(){
  
}

//void checksurrounding(){
//  for (int i = 0; i < lanes.length; i++){
//    if (lanes[i] ){
      
  //  }
  //}
//}
