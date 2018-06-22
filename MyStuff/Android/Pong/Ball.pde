class Ball {

  float x, y, speed, angle, multiplier, dw, dh, ballWidth;
  int hits;

  Ball(float newdw, float newdh) {
    dw = newdw;
    dh = newdh;
    setVals(dw / 2, dh / 2, 0.00625 * dw, 0);
    speed = 0.00625 * dw;
    angle = 180;
    hits = 0;
    ballWidth = (0.02 * dw < (1.0 / 60) * dh) ? 0.0125 * dw : (1.0 / 60) * dh;
  }

  void display() {
    update();
    ellipse(x, y, ballWidth, ballWidth);
  }

  void displaySansUpdate() {
    ellipse(x, y, ballWidth, ballWidth);
  }

  void update() {
    //println(speed);
    if (hits == 2) {
      speed += 0.00125 * dw;
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
    if (abs(x - p.getX()) < ballWidth / 2 + p.getPaddleWidth() / 2 && abs(y - p.getY()) < p.getPaddleHeight() / 2) {
      println("paddle hit");
      print("init ang: " + angle);
      if (y - p.getY() == 0) {
        angle = random(-25, 25);
        if (x > dw / 2) {
          println("yes i should be changing the angle");
          angle = 180 - angle;
          x += speed * cos(radians(angle));
          y += speed * sin(radians(angle));
        }
      } else {
        angle = random(25) + (((y - p.getY()) * 100) / p.getPaddleHeight());
        if (x > dw / 2) {
          println("yes i should be changing the angle");
          angle = 180 - angle;
          x += speed * cos(radians(angle));
          y += speed * sin(radians(angle));
        }
      }
      print("end ang: " + angle);
      hits++;
      return true;
    }
    return false;
  }

  int hitWall() {
    if (y <= ballWidth / 2 || y >= dh - (ballWidth / 2)) {
      angle = -angle;
      return 1;
    } else if (x <= 0.00625 * dw) {
      return 2;
    } else if (x >= 0.99375 * dw) {
      return 3;
    } else return 0;
  }

  int getHits() {
    return hits;
  }
}
