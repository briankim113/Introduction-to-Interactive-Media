boolean partyScreen = false;

void mousePressed() {
  if (partyScreen) {
    partyScreen = false;
    //back to normal setup
    setup();
  } else {
    partyScreen = true;
  }
}

void setup() { 
  size(500, 500);
  background(100);
  textSize(20);
  fill(255);
  textAlign(CENTER);
  text("Click to start the party!", width/2, height/5);

  //face appear as normal

  //head
  fill(255, 240, 217);
  ellipse(width/2, height/2, 115, 150);
  //hair
  fill(0);
  arc(width/2, height/2-25, 100, 100, PI, TWO_PI);  
  //eyes
  fill(255);
  ellipse(width/2.25, height/2.1, 25, 15);
  ellipse(width/1.8, height/2.1, 25, 15);
  fill(0);
  ellipse(width/2.25, height/2.1, 15, 10);
  ellipse(width/1.8, height/2.1, 15, 10);
  //nose
  fill(255, 240, 217);
  triangle(width/2, height/2-5, width/2-10, height/2+25, width/2+10, height/2+25);
  //mouth
  noFill();
  arc(width/2, height/2, 80, 80, radians(45), radians(135));
} 

void draw() {
  int r = int(random(255));
  int g = int(random(255));
  int b = int(random(255));

  if (partyScreen) {
    //do the background flickering here so it changes every time it loops
    background(color(r, g, b));
    textSize(20);
    fill(b, r, g);
    textAlign(CENTER);
    text("Type 'party'!!", width/2, height/5);
    textSize(10);
    text("Or click to stop...", width/2, height/4);

    //keys 1-5 are for different parts of the face
    if (keyPressed) {
      switch (key) {
      case 'p': // head
        fill(255, 240, 217);
        ellipse(width/2, height/2, 115, 150);
        break;
      case 'a': // hair
        fill(0);
        arc(width/2, height/2-25, 100, 100, PI, TWO_PI);    
        break;
      case 'r': // left eye
        fill(255);
        ellipse(width/2.25, height/2.1, 25, 15);
        fill(0);
        ellipse(width/2.25, height/2.1, 15, 10);
        fill(255);
        ellipse(width/1.8, height/2.1, 25, 15);
        fill(0);
        ellipse(width/1.8, height/2.1, 15, 10);
        break;
      case 't': // nose
        fill(255, 240, 217);
        triangle(width/2, height/2-5, width/2-10, height/2+25, width/2+10, height/2+25);
        break;
      case 'y': // mouth
        noFill();
        arc(width/2, height/2, 80, 80, radians(45), radians(135));
      }
    }
  }
}
