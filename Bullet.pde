class Bullet extends Floater {
  double radius;
  double distance_traveled;
  
  Bullet(Spaceship i_spaceship) {
    radius = 5;
    distance_traveled = 0;
    
    corners = 0;
    xCorners = new int[0];
    yCorners = new int[0];
    myCenterX = i_spaceship.get_CenterX();
    myCenterY = i_spaceship.get_CenterY();
    myXspeed = 0;
    myYspeed = 0;
    myPointDirection = i_spaceship.get_PointDirection();
    myColor = color(0xc0, 0xc0, 0xc0);
    accelerate(5);
  } 
  
  void show() {
    fill(myColor);
    stroke(myColor);
    ellipseMode(CORNERS);
    ellipse(
      (float)(myCenterX - radius),
      (float)(myCenterY - radius),
      (float)(myCenterX + radius),
      (float)(myCenterY + radius)
    );
  }
  
  void move() {
    super.move();
    distance_traveled += 5;
  }
  
  double get_CenterX() {
    return myCenterX;
  }
  
  double get_CenterY() {
    return myCenterY;
  }
  
  double get_radius() {
    return radius;
  }
}
