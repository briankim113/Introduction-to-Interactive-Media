//import sound library
import processing.sound.*;
Sound s;

//global image - needs to be web source to maintain background transparency
PImage img = loadImage("https://images.vexels.com/media/users/3/140707/isolated/preview/6f43517c44bc492b7d42b37a78b72ed6-loud-laughing-mouth-by-vexels.png");

//global sine oscillators
SinOsc first = new SinOsc(this);
SinOsc second = new SinOsc(this);
SinOsc third = new SinOsc(this);
SinOsc lead = new SinOsc(this);

//global frequencies
float NOTE_C3 = 131;
float NOTE_D3 = 147;
float NOTE_E3 = 165;
float NOTE_F3 = 175;
float NOTE_G3 = 196;
float NOTE_A3 = 220;
float NOTE_B3 = 247;
float NOTE_C4 = 262;
float NOTE_D4 = 294;
float NOTE_E4 = 330;
float NOTE_F4 = 349;
float NOTE_G4 = 392;
float NOTE_A4 = 440;
float NOTE_B4 = 494;
float NOTE_C5 = 523;


void setup() {
  size(240, 240);
  //starting pitches
  first.freq(NOTE_C3);
  second.freq(NOTE_E3);
  third.freq(NOTE_G3);
  lead.freq(NOTE_C4);
}

void draw() {
  mouth();
  change();
  play();
}


//functions used in draw()

void mouth() {
  background(255);
  fill(0);
  imageMode(CENTER);
  image(img, width/2, height/2, 150, 80+mouseY/2);
}

void change() {
  //change the pitch based on mouseY then display box and note
  if (mouseY <= height/8) { //C
    notes(NOTE_C3, NOTE_E3, NOTE_G3, NOTE_C4);
    boxAndText(0, 'C');
  } else if (height/8 < mouseY && mouseY <= 2*height/8) { //G
    notes(NOTE_D3, NOTE_G3, NOTE_B3, NOTE_D4);
    boxAndText(1, 'D');
  } else if (2*height/8 < mouseY && mouseY <= 3*height/8) { //C
    notes(NOTE_E3, NOTE_G3, NOTE_C4, NOTE_E4);
    boxAndText(2, 'E');
  } else if (3*height/8 < mouseY && mouseY <= 4*height/8) { //Csus4
    notes(NOTE_F3, NOTE_G3, NOTE_C4, NOTE_F4);
    boxAndText(3, 'F');
  } else if (4*height/8 < mouseY && mouseY <= 5*height/8) { //C
    notes(NOTE_G3, NOTE_C4, NOTE_E4, NOTE_G4);
    boxAndText(4, 'G');
  } else if (5*height/8 < mouseY && mouseY <= 6*height/8) { //Am
    notes(NOTE_A3, NOTE_C4, NOTE_E4, NOTE_A4);
    boxAndText(5, 'A');
  } else if (6*height/8 < mouseY && mouseY <= 7*height/8) { //G
    notes(NOTE_B3, NOTE_D4, NOTE_G4, NOTE_B4);
    boxAndText(6, 'B');
  } else {
    notes(NOTE_C4, NOTE_E4, NOTE_G4, NOTE_C5);
    boxAndText(7, 'C');
  }
}

void notes(float f1, float f2, float f3, float f4) {
  first.freq(f1);
  second.freq(f2);
  third.freq(f3);
  lead.freq(f4);
}

void boxAndText(int y1, char c) {
  noStroke();
  fill(255, 0, 0);
  rect(width-40, y1*height/8, width, height/8);
  fill(0);
  text(c, 10, 20);
}

void play() {
  //play the sine oscillators
  first.play();
  second.play();
  third.play();
  lead.play();

  //sound variable created here to compile the sine oscillators with their correct pitches
  s = new Sound(this);

  //adjust volume based on mouseX
  float v = map(mouseX, 0, width, 0.0, 0.5);
  s.volume(v);
}
