class Paddle {

  float x, y, dw, dh, paddleWidth, paddleHeight;

  Paddle(float newX, float newY, float newdw, float newdh) {
    x = newX;
    y = newY;
    dw = newdw;
    dh = newdh;
    paddleWidth = 0.02 * dw;
    paddleHeight = (1.0 / 6) * dh;
  }

  void display() {
    fill(255, 255, 255);
    rect(x - paddleWidth / 2, y - paddleHeight / 2, paddleWidth, paddleHeight);
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getPaddleWidth() {
    return paddleWidth;
  }

  float getPaddleHeight() {
    return paddleHeight;
  }

  void move(float howMuch) {
    if (howMuch < paddleHeight / 2) {
      y = paddleHeight / 2;
    } else if (howMuch > dh - paddleHeight / 2) {
      y = dh - paddleHeight / 2;
    } else y = howMuch;
  }

  void setVals(float newx, float newy) {
    x = newx;
    y = newy;
  }
}
