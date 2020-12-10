class Asteroid extends Floater {
  private final int NUM_DISPLAY_VERTICES = 40;
  private final int SMALLEST_RADIUS = 5;
  
  private int radius;
  private double turn_speed;
  
  public Asteroid(
    int i_radius,
    double i_CenterX, double i_CenterY,
    double i_Xspeed, double i_Yspeed,
    double i_turn_speed
  ) {
    radius = i_radius;
    
    corners = NUM_DISPLAY_VERTICES;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 0;
    yCorners[0] = radius;
    for (int i = 1; i < corners; ++i) {
      double corner_radius = (0.6 * radius) + Math.random() * (0.4 * radius);
      xCorners[i] = (int)(corner_radius * Math.cos(2 * PI / corners * i));
      yCorners[i] = (int)(corner_radius * Math.sin(2 * PI / corners * i));
    }
    myColor = color(0x80, 0x80, 0x80);
    myCenterX = i_CenterX;
    myCenterY = i_CenterY;
    myXspeed = i_Xspeed;
    myYspeed = i_Yspeed;
    myPointDirection = 0;
    turn_speed = i_turn_speed;
  }
  
  public double get_CenterX() {
    return myCenterX;
  }
  
  public double get_CenterY() {
    return myCenterY;
  }
  
  public double get_radius() {
    return radius;
  }
  
  public void set_CenterX(double new_CenterX) {
    myCenterX = new_CenterX;
  }
  
  public void set_CenterY(double new_CenterY) {
    myCenterY = new_CenterY;
  }
  
  public void move() {
    super.move();
    myPointDirection += turn_speed;
  }
}
