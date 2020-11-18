Spaceship ship;
int num_stars;
Star[] stars;
long last_move_time;

public void setup() {
  size(300, 300);
  
  ship = new Spaceship();
  num_stars = 50;
  stars = new Star[num_stars];
  for (int i = 0; i < num_stars; ++i) {
    stars[i] = new Star();
  }
  
  last_move_time = -1;
}

public void draw() {
  background(color(0x00, 0x00, 0x00));
  for (int i = 0; i < num_stars; ++i) {
    stars[i].show();
  }
  ship.show();
  
  // this helps make movement speed independent of frame rate
  if (last_move_time == -1) {
    last_move_time = millis() / 30;
  }
  long current_move_time = millis() / 30; // move once every 30 milliseconds
  for (long i = last_move_time; i < current_move_time; ++i) {
    ship.move();
  }
  last_move_time = current_move_time;
}

public void keyPressed() {
  if (key == ' ') {
    ship.hyperspace_jump();
  }
  if (key == CODED) {
    if (keyCode == UP) {
      ship.accelerate(1);
    }
    else if (keyCode == DOWN) {
      ship.accelerate(-1);
    }
    else if (keyCode == LEFT) {
      ship.turn(-20);
    }
    else if (keyCode == RIGHT) {
      ship.turn(20);
    }
  }
}
