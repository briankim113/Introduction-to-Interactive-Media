//Name: Brian Kim
//Date: April 20, 2020
//Course: Intro to IM

PFont regular;
color c;
Rotater[] rotaters;

void setup() {
  size(700, 700);

  regular = createFont("Atures.ttf", 32);
  c = color(64, 224, 208); //initially turquoise
  rotaters = new Rotater[500];

  for (int i=0; i<rotaters.length; i++) {
    float x = random(width); //changing y
    float y = random(height); //changing x
    float m = random(200, 300); //distance with mouse
    float r = random(20, 40); //distance with other rotater
    rotaters[i]= new Rotater(x, y, i, m, r); //i for index
  }
}

void draw() {
  background(255);
  instructions();
  for (Rotater r : rotaters) {
    r.accelerate();
    r.drawLine(rotaters);
  }
}

void instructions() {
  fill(0);
  textSize(20);
  textFont(regular);
  textAlign(CENTER);
  text("Try Clicking", width/2, height/10);
}

class Rotater {
  float centerX, centerY, x, y, angle, radius, speed, acceleration, direction, dist_m, dist_r;
  int index;

  Rotater(float cx, float cy, int i, float m, float r) {
    centerX = cx;
    centerY = cy;
    index = i;
    dist_m = m;
    dist_r = r;

    x = y = angle = speed = acceleration = 0;
    radius = random(30, 75);

    float coinflip = random(1);
    if (coinflip > .5)
      direction = 1;
    else
      direction = -1;
  }

  void accelerate() {
    //from Aaron's code
    x = cos(angle)*radius + centerX;
    y = sin(angle)*radius + centerY;
    speed += acceleration;
    angle += speed*direction;
    speed *= .98;
    acceleration = 0;

    //accelerate if mouse moves
    if (dist(mouseX, mouseY, x, y) > dist_m
      && mouseX!=pmouseX
      && mouseY!=pmouseY) {
      acceleration = .001;
    }
  }

  void drawLine(Rotater[] rotaters) {
    //change color value if mouse is pressed
    if (mousePressed) {
      float c1 = map(mouseX, 0, width, 0, 255);
      float c2 = map(mouseY, 0, height, 0, 255);
      float c3 = random(0, 255);
      c = color(c1, c2, c3);
    }
    stroke(c);

    //iterate through rotaters
    for (Rotater r : rotaters) {
      //if r is not this rotater
      if (r.index != index) {
        //draw line if distance between this rotater's x,y and other rotaters' x,y < this rotater's dist_r
        if (dist(x, y, r.x, r.y) < dist_r) {
          //but if distance between this rotater's x,y and mouse are too far
          if (dist(mouseX, mouseY, x, y) > dist_r + dist_m)
            stroke(255); //white aka hide
          line(x, y, r.x, r.y);
        }
      }
    }
  }
}
