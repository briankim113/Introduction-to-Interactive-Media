#include <Servo.h>
#include "pitches.h"

Servo myservo;                // create servo object to control a servo
int pos = 0;                  // variable to store the servo position
const int threshold = 10;     // minimum reading of the sensors that generates a note

//variable to store pins
const int servoPin = 9;
const int speakerPin = 8;
const int yellowPin = 4;

// note durations: 4 = quarter note, 2 = half note
int noteDurations[] = {
  4, 4, 4, 4, 4, 4, 2
};

// notes in the melody:
int melody1[] = {
  NOTE_C4, NOTE_C4, NOTE_G4, NOTE_G4, NOTE_A4, NOTE_A4, NOTE_G4
};

int melody2[] = {
  NOTE_F4, NOTE_F4, NOTE_E4, NOTE_E4, NOTE_D4, NOTE_D4, NOTE_C4
};

const int numOfNotes = 7;           // variable used later for the iteration

void setup() {
  myservo.attach(servoPin);          // attaches the servo on pin 9 to the object
  pinMode(yellowPin, INPUT);

  //the first melody plays as a hint during setup before you can do anything for your task (which is in the loop)
  for (int thisNote = 0; thisNote < numOfNotes; thisNote++) {
    int noteDuration = 1000 / noteDurations[thisNote];
    tone(speakerPin, melody1[thisNote], noteDuration);
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
  }
}

void loop() {
  int yellowValue = digitalRead(yellowPin);

  //once you hit the yellow switch (correct answer), the rest of the melody plays
  if (yellowValue){
    for (int thisNote = 0; thisNote < numOfNotes; thisNote++) {
  
      //move servo by 30 degrees per iteration (so it goes from 0 to 180)
      myservo.write(thisNote * 30);
  
      //play a note per iteration
      int noteDuration = 1000 / noteDurations[thisNote];
      tone(speakerPin, melody2[thisNote], noteDuration);
      int pauseBetweenNotes = noteDuration * 1.30;
      delay(pauseBetweenNotes);
    }
  }
}
