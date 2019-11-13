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
 Lane Lone = new Lane(new PVector(0,300),new PVector(1000,300),1);
 Lane Ltwo = new Lane(new PVector(0,350),new PVector(1000,350),2);
 Lane Lthree = new Lane(new PVector(0,400),new PVector(1000,400),3);
 Car one = new Car(60, 4, Lone, new PVector(400,415));
 one.drawCar();
 Lone.drawLane();
 Ltwo.drawLane();
 Lthree.drawLane();
 Lone.addtoLaneArray();
 Ltwo.addtoLaneArray();
 Lthree.addtoLaneArray();
 
 
}

void draw(){

}

void spawncar(){
  
}

//void checksurrounding(){
//  for (int i = 0; i < lanes.length; i++){
//    if (lanes[i] ){
      
  //  }
  //}
//}
