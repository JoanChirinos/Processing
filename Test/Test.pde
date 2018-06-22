void setup() {
  fullScreen();
  background(0, 0, 0);
}

void draw() {
  if (touches.length > 0) {
    background(255 * touches[0].pressure, 0, 0);
  }
  else {
    background(0, 0, 0);
  }
}
