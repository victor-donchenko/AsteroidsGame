class Star {
  private int star_center_x;
  private int star_center_y;
  private int star_radius;
  private color star_color;
  
  public Star() {
    star_center_x = (int)(Math.random() * width);
    star_center_y = (int)(Math.random() * height);
    star_radius = (int)(1 + Math.random() * 2);
    star_color = color(
      (int)(10 + Math.random() * 235),
      (int)(10 + Math.random() * 235),
      (int)(10 + Math.random() * 235)
    );
  }
  
  public void show() {
    stroke(color(0x00, 0x00, 0x00));
    strokeWeight(1);
    fill(star_color);
    ellipseMode(RADIUS);
    ellipse(
      star_center_x,
      star_center_y,
      star_radius,
      star_radius
    );
  }
}
