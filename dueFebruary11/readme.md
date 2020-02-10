## Description

For our second assignment, we were asked to create a switch with digital inputs and outputs. So I decided to mess around with different switches and LED lights.

Green and yellow switches are accepted as digital inputs, which then translate to digital outputs that trigger color-corresponding LED lights to turn on and off.

I added another switch, a blue one, for fun, which triggers the LED lights to blink alternatingly. So one lights up and after 0.3 seconds, it turns off and the other one turns on, and so on.

As you can see in the schematic below, I connected three 10k resistors, connected to the ground, to the three switches (pin 2, 9 - not 11 as the schematic says, and 10), which are also connected to the 5V. And I connected two 330 resistors for the two LED lights (pin 12 and 13).

<img src="schematic.png" alt="schematic" width="320" height="240">

Below you can find a picture of the entire circuit. You can see the video [here](https://youtu.be/uEK43uS2w84) and the arduino code [here](/dueFebruary11/february11.ino).

<img src="switch.JPG" alt="switch" width="320" height="240">
