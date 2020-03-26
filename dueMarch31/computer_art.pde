float t1 = 0;
float t2 = 0; 
char c = 'w'; //default brushstroke = black/white

//stroke color changes per click
void mousePressed() {
  switch(c) {
  case 'w':
    c = 'r';
    break;
  case 'r':
    c = 'g';
    break;
  case 'g':
    c = 'b';
    break;
  case 'b':
    c = 'w';
    break;
  }
}

void setup() {
  size(510, 510);
  frameRate(7); //slower framerate for control
  background(0); //black background
  
  fill(255); //white font
  textSize(15);
  textAlign(CENTER);
  text("Move mouse      left-right for gradation      up-down for angle", width/2, 50);
  text("Click to change color      Press r to restart", width/2, height-50);
  
  //default brushstroke
  c = 'w';
}

void draw() {
  if (keyPressed) {
    if (key == 'r') {
      setup();
    }
  }
  
  //mouseX determines color intensity (left is 0, right is 255)
  switch(c) {
  case 'w': //black/white
    stroke(mouseX/2);
    fill(mouseX/2);
    break;
  case 'r': //red
    stroke(mouseX/2, 100, 100);
    fill(mouseX/2, 100, 100);
    break;
  case 'g': //green
    stroke(100, mouseX/2, 100);
    fill(100, mouseX/2, 100);
    break;
  case 'b': //blue
    stroke(100, 100, mouseX/2);
    fill(100, 100, mouseX/2);
    break;
  }

  //mouseY determines angle
  float a = map(mouseY, 0, height, 0, 360);

  //Perlin noise for translation, t1 and t2 different so it's not a diagonal
  float x = noise(t1);
  x = map(x, 0, 1, 0, width); //map values of x (from 0 to 1) to a value from 0 to width
  t1 += 0.05;

  float y = noise(t2);
  y = map(y, 0, 1, 50, height-50); //map values of x (from 0 to 1) to a value from 0 to width
  t2 += 0.01;

  pushMatrix();
  //translate(x, height/2); // draw just in the middle
  translate(x, y); // draw all over canvas
  rotate(radians(a)); //rotate the line with one point at the new (0,0)
  ellipse(0, 0, 20, 4); // brushstroke
  popMatrix();
}
