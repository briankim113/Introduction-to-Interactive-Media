## Computer Generative Art

### Inspiration

For this week's assignment, we were asked to create a computer generative art.
We were given three sources for inspiration, which you can find [here](http://dada.compart-bremen.de/docUploads/ProgrammInformation21_PI21.pdf), [here](http://dada.compart-bremen.de/docUploads/COMPUTER_GRAPHICS_AND_ART_Feb1977.pdf), and [here](http://dada.compart-bremen.de/docUploads/COMPUTER_GRAPHICS_AND_ART_May1976.pdf).

What I liked about these artworks was that they were simple yet complicated.
Simple lines and shapes overlapping creates something provoking.
But I wanted to create something that demanded more interactivity and creativity from the user.

### Concept

I decided that my computer generative art will act as if the user is painting something on a black canvas.
So they will use an ellipse of a small size that makes it look like a brushstroke, and they can change certain attributes of the brushstroke to make it more interactive:

1) Color (black/white, red, green, blue) by clicking
2) Gradation of the chosen color by moving mouse left-right
3) Angle by moving mouse up-down

What the user cannot control, however, is where they get to place the ellipse.
What determines the x and y coordinates of the brushstroke is the [Perlin noise](https://en.wikipedia.org/wiki/Perlin_noise).
I have created two variables that increase at different increments so that x and y values are always different instead of the same, which would cause a diagonal.

To help the users, I have added instruction which can be shown in the screenshot below:

<img src="instruction.png" alt="top" width="500" height="500">

### Motivation
Creating an illusion of control in an uncontrollable world, this is the motivation behind my program.
But I also want to see how people adapt.
At first, they might feel frustrated, but they can press r and have an empty canvas to start again.
As they grow accustomed to how to move the mouse, they control their art in an uncontrollable environment.
I am really excited to see people try and create something unique.

Check out the video of me trying [here](https://youtu.be/L2C-IfeIo_8) and the code [here](/dueMarch31/computer_art.pde).
