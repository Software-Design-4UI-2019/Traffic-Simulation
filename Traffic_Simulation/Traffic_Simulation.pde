ArrayList<Car> allCars = new ArrayList<Car>();
Lane[] lanes = new Lane[3];
int speedlim = 80;
float coeffF = 0.05;
int avgreacspeed = 3;
int baseaggr = 3;
int maxAcc = 45;
int carl = 40;
int carw = 20;

void setup(){
 size(1000,800);
 Car one = new Car(60, 4, 1, new PVector(400,400));
 println(one.position);
 one.drawcar();
 Lane Lone = new Lane(new PVector(0,300),new PVector(1000,450),1);
 Lane Ltwo = new Lane(new PVector(0,450),new PVector(1000,600),2);
 Lane Lthree = new Lane(new PVector(0,600),new PVector(1000,750),3);
 Lone.drawLane();
 Ltwo.drawLan
 
  
 
 
}

void draw(){

}

void spawncar(){
  
}

void checksurrounding(){
  for (int i = 0; i < lanes.length; i++){
    if (lanes[i] ){
      
    }
  }
}
