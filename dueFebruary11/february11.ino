int buttonYellow = 9;
int buttonGreen = 10;
int buttonBlue = 2;

void setup() {
  // make the buttons' pins inputs:
  pinMode(buttonYellow, INPUT);
  pinMode(buttonGreen, INPUT);
  pinMode(buttonBlue, INPUT);
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input pin:
  int buttonYellowState = digitalRead(buttonYellow); // initially 0 == false
  int buttonGreenState = digitalRead(buttonGreen);
  int buttonBlueState = digitalRead(buttonBlue);

//  // press the button to turn all on or off
//  digitalWrite(12, buttonBlueState);
//  digitalWrite(13, buttonBlueState);

  // press the blue button to blink
  if (buttonBlueState){
    digitalWrite(12, buttonBlueState);
    digitalWrite(13, !buttonBlueState);
    delay(300);                       
    
    digitalWrite(13, buttonBlueState);
    digitalWrite(12, !buttonBlueState);
    delay(300);                       
  }
  
  // press the button for its respective LED light
  digitalWrite(12, buttonYellowState);
  digitalWrite(13, buttonGreenState);
  
}
