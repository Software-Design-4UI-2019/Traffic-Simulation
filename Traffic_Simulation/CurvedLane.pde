class CurvedLane extends Lane{
  CurvedLane(ArrayList<PVector> points, int i){
    super(points.get(1),points.get(points.size() - 2),i);
  }
}
