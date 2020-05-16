 //import sound library
import processing.sound.*;

//global sound files
SoundFile rolling;
SoundFile rolled;

//global sine oscillators
SinOsc first = new SinOsc(this);
SinOsc second = new SinOsc(this);
SinOsc third = new SinOsc(this);
SinOsc lead = new SinOsc(this);

//mouth image needs to be from a web source to maintain background transparency
PImage mouth = loadImage("https://images.vexels.com/media/users/3/140707/isolated/preview/6f43517c44bc492b7d42b37a78b72ed6-loud-laughing-mouth-by-vexels.png");

//global fonts
PFont regular, bold;

//global variables different screens
int screenN;
int side;
int mouseClick;
int margin;

//frequency floats that match the dice result with startFreq which is later used for calculation
float C3 = 131;
float D3 = 147;
float E3 = 165;
float F3 = 175;
float G3 = 196;
float A3 = 220;
float B3 = 247;
float startFreq;

//eyes for the mouth
//inspired by: https://discourse.processing.org/t/makes-eyes-follow-mouse-cursor/13816
class Eye{
  float x, y, rad;
  
  Eye(float _x, float _y, float _rad){
    x = _x;
    y = _y;
    rad = _rad;
  }
}

Eye eye1, eye2;

//char to display the result
char result;

void setup() {
  size(360, 360);                 //360 based on hue
  colorMode(HSB, 360, 100, 100);  //hue, saturation, brightness
  noStroke();
  
  //sound source: http://soundbible.com/tags-rolling-dice.html
  rolling = new SoundFile(this, "roll.wav");
  rolled = new SoundFile(this, "done.wav");
  
  fill(0);
  textAlign(CENTER, TOP);
  regular = createFont("Atures.ttf", 20);
  bold = createFont("AturesBold.ttf", 20);
  
  screenN = 0;
  mouseClick = 0;
  margin = 10;
  
  eye1 = new Eye(width / 4, height / 10, 32);
  eye2 = new Eye(3*width / 4, height / 10, 32);
}

void mouseClicked() {
  if (screenN == 0) {         //dice screen
    if (mouseClick == 0) {
      if (rolling.isPlaying())  rolling.stop();
      if (!rolled.isPlaying())  rolled.play();
      
      //stop the dice and show result
      noLoop();
      diceResult();
      
      //increase mouseClick
      mouseClick++;
    } else {
      //so that user can move to the next screen here on the second click
      if (rolled.isPlaying())  rolled.stop();
      loop();
      screenN = 1;
    }
  } else if (screenN == 1) {    //music screen
    //stop sound and restart
    stopSound();
    setup();
  }
}

void draw() {
  if (screenN == 0) {
    dice();
  } else if (screenN == 1) {
    pitch();
  }
}


//screenN == 0 (dice screen functions)

//inspired by https://www.openprocessing.org/sketch/100534/
void dice() {
  if (!rolling.isPlaying())  rolling.play();
  
  frameRate(10);
  background(#66b2b2);
  
  //draw dice square
  pushStyle();
  
  int diceSize = width/3;
  fill(#FFF3D6);
  rectMode(CENTER);
  rect(width/2, height/2, diceSize, diceSize, diceSize/5);
  
  popStyle();

  //print instructions
  textFont(bold, 20);
  text("Roll & Roll", 0.5*width, 0.1*height);
  textFont(regular, 20);
  text("Click to Stop", 0.5*width, 0.85*height);

  //draw dots for a 7-sided dice
  side = int(random(1, 8));

  if (side == 1 || side == 3 || side == 5 || side == 7){
    ellipse(width/2, height/2, diceSize/5, diceSize/5);
  }
  if (side == 2 || side == 3 || side == 4 || side == 5 || side == 6 || side == 7) { 
    ellipse(width/2 - diceSize/4, height/2 - diceSize/4, diceSize/5, diceSize/5);
    ellipse(width/2 + diceSize/4, height/2 + diceSize/4, diceSize/5, diceSize/5);
  }
  if (side == 4 || side == 5 || side == 6 || side == 7) {
    ellipse(width/2 - diceSize/4, height/2 + diceSize/4, diceSize/5, diceSize/5);
    ellipse(width/2 + diceSize/4, height/2 - diceSize/4, diceSize/5, diceSize/5);
  }
  if (side == 6) {
    ellipse(width/2, height/2 - diceSize/4, diceSize/5, diceSize/5);
    ellipse(width/2, height/2 + diceSize/4, diceSize/5, diceSize/5);
  }
  if (side == 7) {
    ellipse(width/2 - diceSize/4, height/2, diceSize/5, diceSize/5);
    ellipse(width/2 + diceSize/4, height/2, diceSize/5, diceSize/5);
  }

  //based on dice result, set the frequency for notes() function and result for diceResult() function
  setFreq();
}

void setFreq(){
  switch(side) {
    case 1: startFreq = C3; result = 'C'; break;
    case 2: startFreq = D3; result = 'D'; break;
    case 3: startFreq = E3; result = 'E'; break;
    case 4: startFreq = F3; result = 'F'; break;
    case 5: startFreq = G3; result = 'G'; break;
    case 6: startFreq = A3; result = 'A'; break;
    case 7: startFreq = B3; result = 'B'; break;
  }
}

//in the mouseClicked() function
void diceResult() {
  //draw rect over previous instructions
  fill(#66b2b2);
  rect(0, 0.8*height, width, 0.2*height);

  //write the result over it
  fill(0);
  text("In the key of: " + result, 0.5*width, 0.75*height);
  text("Click and Let's Roll!", 0.5*width, 0.85*height);
}




//screenN == 1 (music screen functions)

void pitch() {
  //println(startFreq); //comment in to see the startFreq frequency
  bkgnd(width/2, height/2);
  drawMouth();
  drawEyes();
  change();
}

//inspired by: https://processing.org/examples/radialgradient.html
void bkgnd(float x, float y) {
  //decide hue
  float h = random(0, 360);

  //draw the rectangles
  pushStyle();
  for (int r = width; r > 0; --r) {
    fill(h, 20, 100); //hue, saturation, brightness
    rectMode(CENTER);
    rect(x, y, r, r);
    h = (h + 1) % 360; //go through 360 degrees of hue
  }
  popStyle();
  
  textFont(regular, 20);
  text("Click to Roll Again", 0.5*width, 0.85*height);
}

//use mouse to control the size of the image
void drawMouth() {
  fill(0);
  imageMode(CENTER);
  image(mouth, width/2, height/2, width/2 + mouseX/3, height/2 + mouseY/5);
}

void drawEyes(){
  float ang = atan2(mouseY - eye1.y, mouseX - eye1.x);
  
  //left eye
  fill(#FFFFFF); //white
  ellipse(eye1.x, eye1.y, eye1.rad, eye1.rad);
  fill(0); //black
  ellipse(eye1.x + (eye1.rad / 4) * cos(ang), eye1.y + (eye1.rad / 4) * sin(ang), eye1.rad / 4, eye1.rad / 4);
  
  ang = atan2(mouseY - eye2.y, mouseX - eye2.x);
  
  fill(#FFFFFF);
  ellipse(eye2.x, eye2.y, eye2.rad, eye2.rad);
  fill(0);
  ellipse(eye2.x + (eye2.rad / 4) * cos(ang), eye2.y + (eye2.rad / 4) * sin(ang), eye2.rad / 4, eye2. rad / 4);
}

//change the pitch based on mouseY then display box and note
void change() {
  if (mouseCheck(0)) { //C
    notes(0, 4, 7, 12); //number of half steps from startFreq variable note
    boxAndText(0, "Do");
  } else if (mouseCheck(1)) { //G
    notes(2, 7, 11, 14);
    boxAndText(1, "Re");
  } else if (mouseCheck(2)) { //C
    notes(4, 7, 12, 16);
    boxAndText(2, "Mi");
  } else if (mouseCheck(3)) { //Csus4
    notes(5, 7, 12, 17);
    boxAndText(3, "Fa");
  } else if (mouseCheck(4)) { //C
    notes(7, 12, 16, 19);
    boxAndText(4, "Sol");
  } else if (mouseCheck(5)) { //Am
    notes(9, 12, 16, 21);
    boxAndText(5, "La");
  } else if (mouseCheck(6)) { //G
    notes(11, 14, 19, 23);
    boxAndText(6, "Ti");
  } else if (mouseCheck(7)) { //C
    notes(12, 16, 19, 24);
    boxAndText(7, "Do");
  }
}

//checking mouseposition
Boolean mouseCheck(int y) {
  Boolean bool = (y*height/8 < mouseY && mouseY < (y+1)*height/8);
  return bool;
}

//changing note frequencies
void notes(int h1, int h2, int h3, int h4) {
  first.freq(calcFreq(startFreq, h1));
  second.freq(calcFreq(startFreq, h2));
  third.freq(calcFreq(startFreq, h3));
  lead.freq(calcFreq(startFreq, h4));
  play();
}

//inspired by: https://pages.mtu.edu/~suits/NoteFreqCalcs.html
float calcFreq(float startFreq, float halfSteps) {
  float coeff = pow(1.059463094359, halfSteps);
  float freq = startFreq * coeff;
  return freq;
}

//displaying red box and text
void boxAndText(int y1, String note) {
  //box
  fill(360, 100, 100);
  rect(width-40, y1*height/8, width, height/8);
  
  //text
  fill(0);
  textFont(bold, 32);
  text(note, width/2, height/20);
}

//playing the sounds
void play() {
  //play the sine oscillators
  first.play();
  second.play();
  third.play();
  lead.play();

  //adjust volume based on mouseX
  float v = 0;

  if ((mouseX < margin) || (mouseX >= width - margin) ||
     (mouseY < margin) || (mouseY >= height - margin)) { //out of canvas
    stopSound();
  } else {
    v = map(mouseX, 0, width, 0.1, 0.3); //otherwise map it to mouseX
  }

  first.amp(v);
  second.amp(v);
  third.amp(v);
  lead.amp(v);
}

void stopSound() {
  first.stop();
  second.stop();
  third.stop();
  lead.stop();
}
