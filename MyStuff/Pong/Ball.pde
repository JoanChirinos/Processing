class Ball {
  
  float x, y, speed, angle, multiplier;
  int hits;
  Paddle[] paddles;
  
  Ball() {
    setVals(400, 300, 5, 0);
    speed = 5;
    angle = 180;
    hits = 0;
    paddles = new Paddle[2];
  }
  
  void display() {
    update();
    ellipse(x, y, 10, 10);
  }
  
  void displaySansUpdate() {
    ellipse(x, y, 10, 10);
  }
  
  void update() {
    println(speed);
    if (hits == 5) {
      speed++;
      hits = 0;
    }
    x += speed * cos(radians(angle));
    y += speed * sin(radians(angle));
  }
  
  void setVals(float newx, float newy, float newspeed, float newangle) {
    x = newx;
    y = newy;
    speed = newspeed;
    angle = newangle;
  }
  
  boolean hitPaddle(Paddle p) {
    //if paddle was hit
    if (abs(x - p.getX()) < 15 && abs(y - p.getY()) < 55) {
      if (y - p.getY() == 0) {
        angle = random(-25, 25);
      }
      else {
        angle = random(25) + (y - p.getY());
        if (x > 400) angle = -angle + 180;;
      }
      hits++;
      return true;
    }
    return false;
  }
  
  int hitWall() {
    if (y <= 5 || y >= 595) {
      angle = -angle;
      return 1;
    }
    else if (x <= 5) {
      return 2;
    }
    else if (x >= 795) {
      return 3;
    }
    else return 0;
  }
  
  int getHits() {
    return hits;
  }
  
}
