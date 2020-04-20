//Creator: Brian Kim
//Class: Intro to IM
//Date: April 21, 2020
//Special thanks to Aaron Sherwood for his guest lecture and base code

//global variables
Rotator[] rotators;
PFont regular;
int number = 2;

void setup() {
  size(800, 800);
  background(255);
  regular = createFont("Atures.ttf", 32);

  instruct();

  rotators = new Rotator[number];
  for (int i=0; i < number; i++) {
    float x = random(width);
    float y = random(height);
    rotators[i] = new Rotator(i);
  }
}

//only draws if mouse is pressed and above the boxes
void draw() {
  if ((mousePressed) && (mouseY < height-height/10)) {
    for (Rotator r : rotators) {
      r.updateXY();
      r.drawLine(rotators);
    }
  }
}

//color changes or it restarts
void mouseClicked() {
  //clicks box to change color
  if (mouseY > height-height/10) {
    if (mouseX <= width/4) {
      for (int i=0; i < number; i++) {
        rotators[i].c = color(255, 0, 0);
      }
    } else if (mouseX > width/4 && mouseX <= width/2) {
      for (int i=0; i < number; i++) {
        rotators[i].c = color(0, 255, 0);
      }
    } else if (mouseX > width/2 && mouseX <= 3*width/4) {
      for (int i=0; i < number; i++) {
        rotators[i].c = color(0, 0, 255);
      }
    } else if (mouseX > 3*width/4) {
      for (int i=0; i < number; i++) {
        rotators[i].c = color(0, 0, 0);
      }
    }
  }
  //clicks text to restart
  else if (mouseY < height/10) {
    setup();
  }
}

//instructions that print out in setup
void instruct() { 
  fill(0);
  textSize(20);
  textFont(regular);
  textAlign(CENTER);
  text("Click HERE to restart", width/2, height/10);

  noStroke();
  fill(255, 0, 0);
  rect(0, height-height/10, width/4, height);

  fill(0, 255, 0);
  rect(width/4, height-height/10, width/2, height);

  fill(0, 0, 255);
  rect(width/2, height-height/10, 3*width/4, height);

  fill(0);
  rect(3*width/4, height-height/10, width, height);
}

//Rotator definition
class Rotator {
  float x, y;
  int index;
  color c = color(255, 0, 0);

  Rotator(int _index) {
    x = y = 0;
    index = _index;
  }

  void updateXY() {
    x = mouseX;
    y = mouseY;
  }

  void drawLine(Rotator[] rotators) {
    for (Rotator r : rotators) {
      if (index != r.index) { 
        if (dist(x, y, r.x, r.y) < 60) {
          pushStyle();
          stroke(c);
          line(r.x, r.y, x, y);
          popStyle();
        }
      }
    }
  }
}
