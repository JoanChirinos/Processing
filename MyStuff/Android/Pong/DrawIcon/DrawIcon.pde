float x, y, alpha;

void setup() {
  textAlign(LEFT, TOP);
  PFont f = createFont("CursedTimer.ttf", 10);
  textFont(f);
  size(512, 512);
  background(0, 0, 0);
  x = 50;
  y = 430;
  alpha = 0;
  noStroke();
}

void draw() {
  if (alpha <= 255) {
    fill(255, 255, 255, alpha);
    ellipse(x, y, 40, 40);
    alpha += 40;
    x += 50;
    y -= 20;
  }
  else {
    fill(255, 255, 255);
    rect(440, 100, 40, 330);
    textSize(120);
    text("PONG", 70, 70, 400, 400);
  }
}

void mousePressed() {
  saveFrame("original-512.png");
}
