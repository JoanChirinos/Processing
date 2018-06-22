import cassette.audiofiles.*;

color borderColor;

int x = 0;
int x2 = 0;

float[] lastTouchStore = {0, 0};

int[] scores = {0, 0};

SoundFile wallSound, paddleSound, pointSound;
boolean playSounds = true;
PFont font;

Ball b;
Paddle ps[];

int pointPause;
boolean reset;

float w, h;

void setup() {
  //size(800, 600);
  orientation(LANDSCAPE);
  fullScreen();
  fullScreen();
  fullScreen();
  w = displayWidth;
  h = displayHeight;
  lastTouchStore[0] = h / 2.0;
  lastTouchStore[1] = h / 2.0;
  background(0, 0, 0);

  try {
    wallSound = new SoundFile(this, "wall.wav");
    paddleSound = new SoundFile(this, "paddle.wav");
    pointSound = new SoundFile(this, "point.wav");
  }
  catch (Exception e) {
    println("sounds couldn't load");
    playSounds = false;
  }

  font = createFont("CursedTimer.ttf", 10);
  textFont(font);

  ps = new Paddle[2];
  ps[0] = new Paddle(0.0375 * w, 0.5 * h, w, h);
  ps[1] = new Paddle(w - 0.0375 * w, 0.5 * h, w, h);
  ps[0].display();
  ps[1].display();

  b = new Ball(w, h);
  noStroke();
  resetOnPoint();
}

void draw() {
  println("dw: " + displayWidth);
  println("dh: " + displayHeight);
  if (pointPause == 0) {
    drawBack();
    drawMidline();
    updatePaddles();
    b.display();
    updateBall();
    drawScores();
  } else pointPause--;
}

void drawMidline() {
  stroke(255, 255, 255);
  line(w / 2, 0, w / 2, h);
  noStroke();
}

void updatePaddles() {
  touchDifferences();
  ps[0].move(lastTouchStore[0]);
  ps[1].move(lastTouchStore[1]);
  ps[0].display();
  ps[1].display();
}

void touchDifferences() {
  boolean touchedLeft = false;
  boolean touchedRight = false;
  for (int i = 0; i < touches.length; i++) {
    if (touchedLeft && touchedRight) return;
    float x = touches[i].x;
    float y = touches[i].y;
    if (x < w / 2 && !touchedLeft) {
      //println("touched left");
      touchedLeft = true;
      lastTouchStore[0] = y;
      /*
      if (lastTouchStore[0] == 0) {
       lastTouchStore[0] = y;
       } else {
       ret[0] = y - lastTouchStore[0];
       lastTouchStore[0] = y;
       }
       */
    } else if (x > w / 2 && !touchedRight) {
      //println("touched right");
      touchedRight = true;
      lastTouchStore[1] = y;
      /*
      if (lastTouchStore[1] == 0) {
       lastTouchStore[1] = y;
       } else {
       ret[1] = y - lastTouchStore[1];
       lastTouchStore[1] = y;
       }
       */
    }
  }
}

void updateBall() {
  if (playSounds && b.hitPaddle(ps[0]) || b.hitPaddle(ps[1])) {
    paddleSound.play();
  } else {
    int w = b.hitWall();
    if (w == 1) {
      if (playSounds) wallSound.play();
    } else if (w != 0) {
      //there's been a point
      if (w == 2) scores[0]++;
      else scores[1]++;
      resetOnPoint();
    }
  }
}

void resetOnPoint() {
  if (playSounds) pointSound.play();
  if (scores[0] > scores[1]) b.setVals(w / 2, h / 2, 0.00625 * w, 180);
  else b.setVals(w / 2, h / 2, 0.00625 * w, 0);
  ps[0].setVals(0.0375 * w, 0.5 * h);
  ps[1].setVals(w - 0.0375 * w, 0.5 * h);
  lastTouchStore[0] = h / 2;
  lastTouchStore[1] = h / 2;
  borderColor = color(random(180, 255), random(180, 255), random(180, 255));
  drawBack();
  drawMidline();
  ps[0].display();
  ps[1].display();
  b.displaySansUpdate();
  pointPause = 120;
}

void drawScores() {
  textAlign(RIGHT, TOP);
  textSize(70);
  text(scores[0] + "", (1 / 30.0) * h, (1 / 30.0) * h, 0.45 * w, 0.325 * h);
  textAlign(LEFT, TOP);
  text(scores[1] + "", 0.525 * w, (1 / 30.0) * h, 0.45 * w, 0.325 * h);
}

void drawBack() {
  fill(0, 0, 0);
  stroke(borderColor);
  strokeWeight(5);
  rect(0, 0, w, h);
  noStroke();
  fill(255, 255, 255);
}
