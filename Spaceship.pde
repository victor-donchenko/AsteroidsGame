class Spaceship extends Floater {
  public Spaceship() {
    corners = 3; // make it a triangle
    xCorners = new int[corners];
    yCorners = new int[corners];
    
    xCorners[0] = -5;
    yCorners[0] = 5;
    xCorners[1] = -5;
    yCorners[1] = -5;
    xCorners[2] = 10;
    yCorners[2] = 0;
    
    myColor = color(0xff, 0xff, 0xff);
    
    myCenterX = 150;
    myCenterY = 150;
    
    myXspeed = 0;
    myYspeed = 0;
    
    myPointDirection = 0;
  }
  
  public void hyperspace_jump() {
    myCenterX = (int)(Math.random() * width);
    myCenterY = (int)(Math.random() * height);
    myPointDirection = Math.random() * 360;
  }
  
  public double get_CenterX() {
    return myCenterX;
  }
  
  public double get_CenterY() {
    return myCenterY;
  }
  
  public int get_num_corners() {
    return corners;
  }
  
  public double get_corner_x(int index) {
    return myCenterX + xCorners[index] * Math.cos(myPointDirection)
                     - yCorners[index] * Math.sin(myPointDirection);
  }
  
  public double get_corner_y(int index) {
    return myCenterY + xCorners[index] * Math.sin(myPointDirection)
                     - yCorners[index] * Math.cos(myPointDirection);
  }
  
  public double get_PointDirection() {
    return myPointDirection;
  }
}
