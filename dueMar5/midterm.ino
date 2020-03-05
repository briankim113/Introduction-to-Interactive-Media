// include the library for LCD
#include <LiquidCrystal.h>

//declare const int for switches, speakers, and potentiometers
const int switch1Pin = 7, switch2Pin = 5, switch3Pin = 3;
const int tone1Pin = 6, tone2Pin = 4, tone3Pin = 2;
const int poten2Pin = A2, poten3Pin = A3;

//declare const int for LCD interface pins and initialize library
const int rs = 13, en = 12, d4 = 11, d5 = 10, d6 = 9, d7 = 8;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

void setup() {
  pinMode(switch1Pin, INPUT);
  pinMode(switch2Pin, INPUT);
  pinMode(switch3Pin, INPUT);

  //print title
  lcd.begin(16, 2);
  lcd.print("Do - Mi - Sol");

  tone(tone1Pin, 526, 2000);
  delay(2000);
  
//print the "instruction" now so it only does it once and not go through loop and stays there
//  lcd.setCursor(0, 1);
//  lcd.print("Tuning...");
}

void loop() {
  int poten2Value = analogRead(poten2Pin);
  int poten3Value = analogRead(poten3Pin);

  int switch1Value = digitalRead(switch1Pin);
  int switch2Value = digitalRead(switch2Pin);
  int switch3Value = digitalRead(switch3Pin);

  //from 0 to 1023 of potentiometer to 523-1047 which are pitches from C5 to C6
  int mapped2Value = map(poten2Value, 0, 1023, 523, 1047);
  int mapped3Value = map(poten3Value, 0, 1023, 523, 1047);

  int diff2 = mapped2Value - 660;
  int diff3 = mapped3Value - 779;

  //some switch is pressed then play the corresponding speaker
  //noTone before tone
  if (switch1Value) {
    noTone(tone2Pin);
    noTone(tone3Pin);
    tone(tone1Pin, 526);
  }
  else if (switch2Value) {
    noTone(tone1Pin);
    noTone(tone3Pin);
    tone(tone2Pin, mapped2Value);
  }
  else if (switch3Value) {
    noTone(tone1Pin);
    noTone(tone2Pin);
    tone(tone3Pin, mapped3Value);
  }
  //nothing is pushed then play no tones
  else {
    noTone(tone1Pin);
    noTone(tone2Pin);
    noTone(tone3Pin);
  }

  int value = 10;
  
  //check if the pitches are right first so light is set before it runs the rest of loop
  if ((diff2 > -value && diff2 < value) && (diff3 > -value && diff3 < value)) {
    lcd.setCursor(0, 1);
    lcd.print("Congrats!");
  } else if ((diff2 > -value && diff2 < value) || (diff3 > -value && diff3 < value)) {
    //replace "Tuning..."
    lcd.setCursor(0, 1);
    lcd.print("Closer...");
  } else {
     lcd.setCursor(0, 1);
     lcd.print("Tuning...");
  }
}
