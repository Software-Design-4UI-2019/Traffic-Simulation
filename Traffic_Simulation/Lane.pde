class Lane{
  PVector startpoint;
  PVector endpoint;
  int laneid;
  Car[] lanecars;
  
 Lane(PVector s, PVector e, int i){
  this.startpoint =  s;
  this.endpoint = e;
  this.laneid = i;
  this.lanecars = new Cars[];
  
}}
