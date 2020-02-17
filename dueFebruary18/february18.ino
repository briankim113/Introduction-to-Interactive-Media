const int sensor = A3;
const int lightSwitch = 4;
const int typeSwitch = 2;

const int yellowLED = 6;
const int greenLED = 11;
int currentLED;
int unusedLED;

void setup() {
  pinMode(lightSwitch, INPUT);
  pinMode(typeSwitch, INPUT);

  pinMode(yellowLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
}

void loop() {
  int sensorValue = analogRead(sensor);
  int lightValue = digitalRead(lightSwitch);
  int typeValue = digitalRead(typeSwitch);

  int mappedValue = map(sensorValue, 200, 800, 0, 255);
  mappedValue = constrain(mappedValue, 0, 255);

  //lightValue switches the LED
  if (lightValue == 0) {
    currentLED = yellowLED;
    unusedLED = greenLED;
  } else {
    currentLED = greenLED;
    unusedLED = yellowLED;
  }

  //typeValue switches analogWrite or digitalWrite
  if (typeValue == 0) {                   
    digitalWrite(unusedLED, LOW);         // this digitalWrite ensures that the unused LED light turns off instead of staying on the mappedValue from before
    analogWrite(currentLED, mappedValue); // brightness determined by analog input
  } else {
    digitalWrite(currentLED, HIGH);       // blink!
    delay(mappedValue * 10);              // speed of delay is determined by analog input
    digitalWrite(currentLED, LOW);
    delay(mappedValue * 10);
  }

}
