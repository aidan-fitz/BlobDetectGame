class Ball {
  
  private PVector pos, pos1, pos2, vel, vel1, accel;
  
  Ball() {
    
  }
  
  void setxy(float x, float y) {
    pos2 = pos1;
    pos1 = pos;
    pos = new PVector(x, y);
    vel1 = vel;
    vel = diff(pos1, pos);
    accel = diff(vel1, vel);
  }
  
  PVector diff(PVector v1, PVector v2) {
    float x = v2.x - v1.x,
          y = v2.y - v1.y;
    return new PVector(x, y);
  }
}
