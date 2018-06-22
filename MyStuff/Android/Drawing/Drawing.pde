final int DRAW_SCREEN = 0;
final int COLOR_PICK_SCREEN = 1;
final String frameName = "frame.png";

float dw;
float dh;
int r;
int g;
int b;

int diameter;

color drawColor;
PGraphics pg;
int state;

void setup() {
  frameRate(1000);
  orientation(LANDSCAPE);
  noStroke();
  size(displayWidth, displayHeight);
  background(255, 255, 255);
  textAlign(CENTER, CENTER);
  textSize(20);
  pg = createGraphics(displayWidth, displayHeight);
  pg.beginDraw();
  pg.background(255, 255, 255, 0);
  pg.noStroke();
  pg.endDraw();
  dw = displayWidth;
  dh = displayHeight;
  diameter = 10;
  r = 0;
  g = 0;
  b = 0;
  drawColor = color(r, g, b);
  state = DRAW_SCREEN;
}

void draw() {
  if (state == DRAW_SCREEN) {
    drawDrawScreen();
  }
  else if (state == COLOR_PICK_SCREEN) {
    drawColorPickScreen();
  }
}

void drawDrawScreen() {
  /*for (int i = 0; i < touches.length; i++) {
    float x = touches[i].x;
    float y = touches[i].y;
    fill(drawColor);
    pg.ellipse(x, y, 10, 10);
  }*/
  background(255, 255, 255);
  pg.beginDraw();
  for (int i = 0; i < touches.length; i++) {
    float x = touches[i].x;
    float y = touches[i].y;
    if (x > dw - 105 && x < dw - 5 && y > 5 && y < 45) {
      pg.endDraw();
      state = COLOR_PICK_SCREEN;
      return;
    }
    else if (y > 50) {
      pg.fill(r, g, b);
      pg.ellipse(x, y, diameter, diameter);
    }
  }
  pg.endDraw();
  image(pg, 0, 0);
  fill(200, 200, 200);
  rect(0, 0, dw, 50);
  stroke(0, 0, 0);
  drawButton("Pick Color", dw - 110, 5, 105, 40);
  drawButton("<", 5, 5, 40, 40);
  drawTextBox("", 50, 5, 40, 40);
  drawButton(">", 95, 5, 40, 40);
  fill(0, 0, 0);
  ellipse(70, 25, diameter, diameter);
  line(0, 50, dw, 50);
  noStroke();
}

void drawColorPickScreen() {
  background(0, 0, 0);
  if (touchIsStarted) {
    for (int i = 0; i < touches.length; i++) {
      float x = touches[i].x;
      float y = touches[i].y;
      if (x > 5 && y < 105 && x < 105 && y > 5) {
        state = DRAW_SCREEN;
        return;
      }
    }
  }
  
  stroke(0, 0, 0);
  drawButton("<<<", 75, 100, 50, 50);
  drawButton("<<", 125, 100, 50, 50);
  drawButton("<", 175, 100, 50, 50);
  drawTextBox(r + "", 225, 100, 50, 50);
  drawButton(">", 275, 100, 50, 50);
  drawButton(">>", 325, 100, 50, 50);
  drawButton(">>>", 375, 100, 50, 50);
  
  drawButton("<<<", 75, 175, 50, 50);
  drawButton("<<", 125, 175, 50, 50);
  drawButton("<", 175, 175, 50, 50);
  drawTextBox(g + "", 225, 175, 50, 50);
  drawButton(">", 275, 175, 50, 50);
  drawButton(">>", 325, 175, 50, 50);
  drawButton(">>>", 375, 175, 50, 50);
  
  drawButton("<<<", 75, 250, 50, 50);
  drawButton("<<", 125, 250, 50, 50);
  drawButton("<", 175, 250, 50, 50);
  drawTextBox(b + "", 225, 250, 50, 50);
  drawButton(">", 275, 250, 50, 50);
  drawButton(">>", 325, 250, 50, 50);
  drawButton(">>>", 375, 250, 50, 50);
  
  stroke(255, 255, 255);
  fill(r, g, b);
  rect(75, 350, 350, 100);
  
  fill(200, 200, 200);
  rect(0, 0, 500, 50);
  stroke(0, 0, 0);
  drawButton("Back", 5, 5, 100, 40);
  line(0, 50, 500, 50);
  noStroke();
}

void mouseReleased() {
  if (state == DRAW_SCREEN) {
  drawButton("", 5, 5, 40, 40);
  drawButton("", 50, 5, 40, 40);
  drawButton("", 95, 5, 40, 40);
    if (hovering(5, 5, 40, 40)) {
      if (diameter > 2) diameter--;
    }
    if (hovering(95, 5, 40, 40)) {
      if (diameter < 40) diameter++;
    }
  }
  if (state == COLOR_PICK_SCREEN) {
    if (hovering(75, 100, 50, 50)) {
      r -= 100;
      if (r < 0) {
        r = 0;
      }
    }
    if (hovering(125, 100, 50, 50)) {
      r -= 10;
      if (r < 0) {
        r = 0;
      }
    }
    if (hovering(175, 100, 50, 50)) {
      r -= 1;
      if (r < 0) {
        r = 0;
      }
    }
    if (hovering(275, 100, 50, 50)) {
      r += 1;
      if (r > 255) {
        r = 255;
      }
    }
    if (hovering(325, 100, 50, 50)) {
      r += 10;
      if (r > 255) {
        r = 255;
      }
    }
    if (hovering(375, 100, 50, 50)) {
      r += 100;
      if (r > 255) {
        r = 255;
      }
    }
    if (hovering(75, 175, 50, 50)) {
      g -= 100;
      if (g < 0) {
        g = 0;
      }
    }
    if (hovering(125, 175, 50, 50)) {
      g -= 10;
      if (g < 0) {
        g = 0;
      }
    }
    if (hovering(175, 175, 50, 50)) {
      g -= 1;
      if (g < 0) {
        g = 0;
      }
    }
    if (hovering(275, 175, 50, 50)) {
      g += 1;
      if (g > 255) {
        g = 255;
      }
    }
    if (hovering(325, 175, 50, 50)) {
      g += 10;
      if (g > 255) {
        g = 255;
      }
    }
    if (hovering(375, 175, 50, 50)) {
      g += 100;
      if (g > 255) {
        g = 255;
      }
    }
    if (hovering(75, 250, 50, 50)) {
      b -= 100;
      if (b < 0) {
        b = 0;
      }
    }
    if (hovering(125, 250, 50, 50)) {
      b -= 10;
      if (b < 0) {
        b = 0;
      }
    }
    if (hovering(175, 250, 50, 50)) {
      b -= 1;
      if (b < 0) {
        b = 0;
      }
    }
    if (hovering(275, 250, 50, 50)) {
      b += 1;
      if (b > 255) {
        b = 255;
      }
    }
    if (hovering(325, 250, 50, 50)) {
      b += 10;
      if (b > 255) {
        b = 255;
      }
    }
    if (hovering(375, 250, 50, 50)) {
      b += 100;
      if (b > 255) {
        b = 255;
      }
    }
  }
}

void clear() {
  
}

void drawButton(String t, float x, float y, float w, float h) {
  if (hovering(x, y, w, h)) {
    fill(220, 220, 220);
  }
  else {
    fill(255, 255, 255);
  }
  rect(x, y, w, h);
  fill(0, 0, 0);
  text(t, x, y, w, h);
}

void drawTextBox(String t, float x, float y, float w, float h) {
  fill(255, 255, 255);
  rect(x, y, w, h);
  fill(0, 0, 0);
  text(t, x, y, w, h);
}

boolean hovering(float x, float y, float w, float h) {
  for (int i = 0; i < touches.length; i++) {
    float tx = touches[i].x;
    float ty = touches[i].y;
    if(tx > x && tx < (x + w) && ty > y && ty < (y + h)) return true;
  }
  return false;
}
