//Title: OOP Ping-Pong
//Author: Brian Kim
//Last modified: Apr 6, 2020

//Special thanks to Amy Kang for letting me adapt her sparkle() function

int screenW, screenH, screenN;  //global variables
Game game;                      //instantiate globally, initialize in mouseClicked()


void setup() {
  size(600, 500);
  smooth();
  screenW = width;
  screenH = height;
  screenN = 0;              //setup() makes sure the first screen is instructions
}

void draw() {
  background(0);
  fill(255);
  textSize(24);
  textAlign(CENTER);
  frameRate(60);             //make sure game is played at normal frameRate

  if (screenN == 0) {        //instructions
    introScreen();
  } else if (screenN == 1) { //game playing
    game.play();
  } else if (screenN == 2) { //game done
    overScreen();
  }
}



void introScreen() {
  text("Ping Pong", screenW/2, screenH/5);
  text("Click to play!", screenW/2, screenH-100);

  pushStyle(); //save default text style

  textSize(18);
  text("by Brian Kim", screenW/2, screenH/5+30);
  text("Press W and S for Player 1", screenW/2, screenH/2);
  text("Press UP and DOWN for Player 2", screenW/2, screenH/2+25);

  popStyle(); //restore default text style
}

void overScreen() {
  pushStyle();  //save default text style

  if (game.ball.x < 0) {
    fill(0, 0, 255);
    text("Player 2 won!", screenW/2, screenH/4);
  } else if (game.ball.x > screenW) {
    fill(255, 0, 0);
    text("Player 1 won!", screenW/2, screenH/4);
  }

  //sparkle
  frameRate(20); //slow down sparkle moving
  for (int j = 0; j < 30; j++) { //30 strokes appear at random places like confetti
    sparkle(random(0, screenW), random(0, screenH));
  }

  popStyle(); //restore default text style

  text("Click to restart", screenW/2, screenH - screenH/4);
}

void sparkle(float x, float y) {
  //the color of the strokes are random
  stroke(random(0, 255), random(0, 255), random(0, 255));
  strokeWeight(2);
  //the length/direction of the strokes are random (within the given range)
  float xlength = random(-40, 40);
  float ylength = random(-40, 40);
  pushMatrix();
  translate(x, y);
  line(0, 0, xlength, ylength);
  popMatrix();
}



class Game {
  //instantiate
  Ball ball;
  Bar p1, p2;

  //constructor - initialize
  Game() {
    ball = new Ball(screenW/2, screenH/2);
    p1 = new Bar(0);
    p2 = new Bar(screenW-15);
  }

  void play() {
    ball.updateBall();
    ball.drawBall();

    p1.updateBar();
    p1.drawBar('r'); //red

    p2.updateBar();
    p2.drawBar('b'); //blue
  }
}


class Ball {
  //instantiate
  float x, y, xSpeed, ySpeed;
  int r;

  //constructor - initialize
  Ball(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    xSpeed = -4; //p1 goes first
    ySpeed = 5;
    r = 25;
  }

  void drawBall() {
    fill(255);
    ellipse(x, y, r, r);
  }

  void updateBall() {
    x += xSpeed;
    y += ySpeed;

    //ball is off screen
    if (x < 0 || x > screenW) {
      screenN = 2; //game over
    }

    //ball hits p1 or p2
    if ((x < game.p1.w+r) && (y > game.p1.y) && (y < game.p1.y+game.p1.h)) {
      xSpeed = -xSpeed;
      xSpeed += 0.5;                //goes to right faster
    } else if ((x > screenW-game.p2.w-r) && (y > game.p2.y) && (y < game.p2.y+game.p2.h)) {
      xSpeed = -xSpeed;
      xSpeed -= 0.5;                //goes to left faster
    }

    //ball hits top or bottom
    if (y < r) {                     //hits top
      ySpeed = -ySpeed;
      ySpeed += 0.5;                //goes down faster
    } else if (y > screenH-r) {     //hits bottom
      ySpeed = -ySpeed;
      ySpeed -= 0.5;                //goes up faster
    }
  }
}


class Bar {
  //instantiate
  float x, y;
  int w, h, ySpeed;
  boolean upPressed, downPressed; // bools so that p1 and p2 respond to keys separately

  Bar(float xpos) {
    x = xpos;                //left-top corner x
    y = 3 * screenH/8;       //left-top corner y
    w = 15;                  //width of bar
    h = screenH/4;           //height of bar
  }

  void drawBar(char barColor) {
    if (barColor == 'r')      //diff colors for p1 and p2
      fill(255, 0, 0);
    else if (barColor == 'b')
      fill(0, 0, 255);
    rect(x, y, w, h, 7);     //7 is for corner
  }

  void updateBar() {
    if (y <= 0) {                   //bar reached top
      upPressed = false;            //can't go higher
    } else if (y+h >= screenH) {    //bar reached bottom
      downPressed = false;          //can't go lower
    }

    if (upPressed) {
      ySpeed = -8;
    } else if (downPressed) {
      ySpeed = 8;
    } else {
      ySpeed = 0;                    //don't move if both are false
    }    
    y += ySpeed;
  }
}


void keyPressed() {
  //separate keys for separate players
  //continues moving as long as keyPressed
  if (key == 'w') {
    game.p1.upPressed = true;
  } else if (key == 's') {
    game.p1.downPressed = true;
  } else if (keyCode == UP) {
    game.p2.upPressed = true;
  } else if (keyCode == DOWN) {
    game.p2.downPressed = true;
  }
}

void keyReleased() {
  //separate keys for separate players
  //stops moving if keyReleased
  if (key == 'w') {
    game.p1.upPressed = false;
  } else if (key == 's') {
    game.p1.downPressed = false;
  } else if (keyCode == UP) {
    game.p2.upPressed = false;
  } else if (keyCode == DOWN) {
    game.p2.downPressed = false;
  }
}

void mouseClicked() {
  //changes screen from instructions to game to over and again
  if (screenN == 0 || screenN == 2) { //instruction or over screen
    game = new Game();                //create a new game
    screenN = 1;                      //game screen
  }
}
