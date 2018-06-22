boolean wasTouched;
float dR, dG, dB;
boolean touched;

void setup() {
  orientation(LANDSCAPE);
  size(displayWidth, displayHeight);
  background(0, 0, 0);
  noStroke();
  frameRate(240);
  touched = false;
  println("dW: " + displayWidth);
  println("dH: " + displayHeight);
}

void draw() {
  if (!wasTouched) {
    fill(255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(30);
    text("Tap the screen!", 0, 0, displayWidth, displayHeight);
  }
  fill(255, 255, 255);
  rect(displayWidth - 200, 0, 200, 100);
  fill(0, 0, 0);
  text("Clear", displayWidth - 200, 0, 200, 100);
  for (int i = 0; i < touches.length; i++) {
    if (!(touches[i].x > displayWidth - 200 && touches[i].y < 100)) {
      fill(hue(color(dR, dG, dB)) + 180);
      ellipse(touches[i].x, touches[i].y, 30, 30);
    }
  }
}

void touchEnded() {
  touched = false;
}

void touchStarted() {
  if (!wasTouched) {
    clearScreen();
    wasTouched = true;
  }
  for (int i = 0; i < touches.length; i++) {
    println("dW: " + displayWidth);
    println("dH: " + displayHeight);
    println("x: " + touches[i].x);
    println("y: " + touches[i].y);
    if (touches[i].x > displayWidth - 200 && touches[i].y < 100 && !touched) {
      clearScreen();
      println("clear bois");
      touched = true;
    }
  }
}

void clearScreen() {
    dR = random(0, 255);
    dG = random(0, 255);
    dB = random(0, 255);
    background(dR, dG, dB);
}
