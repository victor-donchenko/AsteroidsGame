Spaceship ship;
int num_stars;
Star[] stars;
ArrayList<Asteroid> asteroids;
long last_move_time;
boolean end_of_game;

public void setup() {
  size(300, 300);
  
  ship = new Spaceship();
  num_stars = 50;
  stars = new Star[num_stars];
  for (int i = 0; i < num_stars; ++i) {
    stars[i] = new Star();
  }
  asteroids = new ArrayList<Asteroid>();
  
  last_move_time = -1;
  end_of_game = false;
}

void generate_asteroid() {
  int radius = (int)(5 + Math.random() * 10);
  int side = (int)(Math.random() * 4);
  
  double start_x = 0;
  double start_y = 0;
  switch (side) {
  case 0:
    start_x = -radius;
    start_y = Math.random() * height;
    break;
  case 1:
    start_x = width + radius;
    start_y = Math.random() * height;
    break;
  case 2:
    start_x = Math.random() * width;
    start_y = -radius;
    break;
  case 3:
    start_x = Math.random() * width;
    start_y = height + radius;
    break;
  }
  
  double velocity = 1 + Math.random() * 1;
  double direction = 2 * PI * Math.random();
  
  Asteroid new_asteroid = new Asteroid(
    radius,
    start_x, start_y,
    velocity * Math.cos(direction),
    velocity * Math.sin(direction),
    (-1) + 2 * Math.random()
  );
  asteroids.add(new_asteroid);
}

public void draw() {
  background(color(0x00, 0x00, 0x00));
  
  if (end_of_game) {
    fill(color(0xff, 0xff, 0xff));
    text("GAME OVER SCREEN", 100, 100);
    return;
  }
  
  for (int i = 0; i < num_stars; ++i) {
    stars[i].show();
  }
  for (int i = 0; i < asteroids.size(); ++i) {
    asteroids.get(i).show();
  }
  ship.show();
  
  // this helps make movement speed independent of frame rate
  if (last_move_time == -1) {
    last_move_time = millis() / 30;
  }
  long current_move_time = millis() / 30; // move once every 30 milliseconds
  for (long i = last_move_time; i < current_move_time; ++i) {
    ship.move();
    for (int j = 0; j < asteroids.size(); ++j) {
      asteroids.get(j).move();
      for (int k = 0; k < ship.get_num_corners(); ++k) {
        double distance = Math.sqrt(
          Math.pow(ship.get_corner_x(k) - asteroids.get(j).get_CenterX(), 2)
          + Math.pow(ship.get_corner_y(k) - asteroids.get(j).get_CenterY(), 2)
        );
        if (distance < asteroids.get(j).get_radius()) {
          end_of_game = true;
        }
      }
    }
    if (Math.random() < 0.01) {
      generate_asteroid();
    }
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
      ship.turn(-15);
    }
    else if (keyCode == RIGHT) {
      ship.turn(15);
    }
  }
}
