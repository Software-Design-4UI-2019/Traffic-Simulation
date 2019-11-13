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
 one.drawCar();
 
 
}

void draw(){

}
