Spaceship ship;
int num_stars;
Star[] stars;
ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
long delay_until_shoot;
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
  bullets = new ArrayList<Bullet>();
  delay_until_shoot = 0;
  
  last_move_time = -1;
  end_of_game = false;
}

Asteroid generate_asteroid(int radius) {
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
  
  double velocity = 0.5 + Math.random() * 0.;
  double direction = 2 * PI * Math.random();
  
  Asteroid new_asteroid = new Asteroid(
    radius,
    start_x, start_y,
    velocity * Math.cos(direction),
    velocity * Math.sin(direction),
    (-1) + 2 * Math.random()
  );
  asteroids.add(new_asteroid);
  return new_asteroid;
}

void move_asteroid_to_other(Asteroid a, Asteroid b) {
  a.set_CenterX(b.get_CenterX());
  a.set_CenterY(b.get_CenterY());
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
  for (int i = 0; i < bullets.size(); ++i) {
    bullets.get(i).show();
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
      for (int k = 0; k < bullets.size(); ++k) {
        Bullet bullet = bullets.get(k);
        double distance = Math.sqrt(
          Math.pow(bullet.get_CenterX() - asteroids.get(j).get_CenterX(), 2)
          + Math.pow(bullet.get_CenterY() - asteroids.get(j).get_CenterY(), 2)
        );
        if (distance < asteroids.get(j).get_radius() + bullet.get_radius()) {
          if (asteroids.get(j).radius > 15) {
            int total_radius = asteroids.get(j).radius;
            int subradius1 = (int)(5 + Math.random() * (total_radius - 15));
            int subradius2 = (int)(5 + Math.random() * (total_radius - subradius1 - 10));
            int subradius3 = total_radius - subradius1 - subradius2;
            Asteroid subasteroid1 = generate_asteroid(subradius1);
            move_asteroid_to_other(subasteroid1, asteroids.get(j));
            Asteroid subasteroid2 = generate_asteroid(subradius2);
            move_asteroid_to_other(subasteroid2, asteroids.get(j));
            Asteroid subasteroid3 = generate_asteroid(subradius3);
            move_asteroid_to_other(subasteroid3, asteroids.get(j));
          }
          asteroids.remove(j);
          --j;
          bullets.remove(k);
          --k;
          break;
        }
      }
    }
    
    for (int j = 0; j < bullets.size(); ++j) {
      bullets.get(j).move();
      if (bullets.get(j).distance_traveled > 300) {
        bullets.remove(j);
        --j;
      }
    }
    if (Math.random() < 0.01) {
      generate_asteroid((int)(5 + Math.random() * 20));
    }
    
    if (delay_until_shoot != 0) {
      --delay_until_shoot;
    }
  }
  last_move_time = current_move_time;
}

public void keyPressed() {
  if (key == ' ') {
    ship.hyperspace_jump();
  }
  if (key == 's') {
    if (delay_until_shoot == 0) {
      Bullet new_bullet = new Bullet(ship);
      bullets.add(new_bullet);
      delay_until_shoot = 20;
    }
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
