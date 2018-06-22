import processing.sound.*;

int x = 0;
int x2 = 0;

//[playerOneMotion, playerTwoMotion] such that 1 = up, -1 = down, 0 = none
int[] keys = {0, 0};

int[] scores = {0, 0};

SoundFile wallSound, paddleSound, pointSound;
PFont font;

Ball b;
Paddle ps[];

int pointPause;
boolean reset;

void setup() {
  size(800, 600);
  background(0, 0, 0);

  wallSound = new SoundFile(this, "wall.wav");
  paddleSound = new SoundFile(this, "paddle.wav");
  pointSound = new SoundFile(this, "point.wav");
  
  font = createFont("CursedTimer.ttf", 10);
  textFont(font);

  ps = new Paddle[2];
  ps[0] = new Paddle(25, 300);
  ps[1] = new Paddle(775, 300);
  
  b = new Ball();
  
  pointPause = 120;
  
  noStroke();
}

void draw() {
  if (pointPause == 0) {
    background(0, 0, 0);
    drawDashes();
    updatePaddles();
    b.display();
    updateBall();
    drawScores();
  }
  else pointPause--;
}

void drawDashes() {
  for (int i = 0; i < 20; i++) {
    rect(397.5, 2 *i * (600.0 / 39), 5, (600.0 / 39));
  }
}

void updatePaddles() {
  if (keys[0] == -1) ps[0].down();
  else if (keys[0] == 1) ps[0].up();
  
  if (keys[1] == -1) ps[1].down();
  else if (keys[1] == 1) ps[1].up();
  
  ps[0].display();
  ps[1].display();
}

void updateBall() {
  if (b.hitPaddle(ps[0])) {
    paddleSound.play();
  }
  else if (b.hitPaddle(ps[1])) {
    paddleSound.play();
  }
  else {
    int w = b.hitWall();
    if (w == 1) {
      wallSound.play();
    }
    else if (w != 0) {
      //there's been a point
      if (w == 2) scores[0]++;
      else scores[1]++;
      resetOnPoint();
    }
  }
}

void resetOnPoint() {
  pointSound.play();
  if (scores[0] > scores[1]) b.setVals(400, 300, 5, 0);
  else b.setVals(400, 300, 5, 180);
  ps[0].setVals(25, 300);
  ps[1].setVals(775, 300);
  background(0, 0, 0);
  drawDashes();
  ps[0].display();
  ps[1].display();
  b.displaySansUpdate();
  pointPause = 120;
}

void drawScores() {
  textAlign(RIGHT, TOP);
  textSize(70);
  text(scores[0] + "", 20, 20, 360, 260);
  textAlign(LEFT, TOP);
  text(scores[1] + "", 420, 20, 360, 260);
}

void keyPressed() {
  if (key == 'w') keys[0] = 1;
  if (key == 's') keys[0] = -1;
  if (key == CODED && keyCode == UP) keys[1] = 1;
  if (key == CODED && keyCode == DOWN) keys[1] = -1;
}

void keyReleased() {
  if (key == 'w' || key == 's') keys[0] = 0;
  if (key == CODED && (keyCode == UP || keyCode == DOWN)) keys[1] = 0;
}
