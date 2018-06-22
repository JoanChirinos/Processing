class Paddle {
  
  float x, y;
  
  Paddle(float newX, float newY) {
    x = newX;
    y = newY;
  }
  
  void display() {
    rect(x - 10, y - 50, 20, 100);
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  void up() {
    if (y > 50) y -= 5;
  }
  
  void down() {
    if (y < 550) y += 5;
  }
  
  void setVals(float newx, float newy) {
    x = newx;
    y = newy;
  }
  
}
