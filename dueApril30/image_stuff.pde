//Title: Explosion
//By: Brian Kim
//Last Modified: April 30th, 2020
//Tweaked from: https://processing.org/tutorials/pixels/

PImage img;

void setup() {
  size(256, 256, P3D);           //canvas size needs to be the same as image size
  img  = loadImage("lily.jpg");  //load the image         
}

void draw() {
  //load pixels
  loadPixels();
  //grab the pixel color of the image at the mouseX, mouseY
  color b = img.pixels[mouseX + mouseY * width];
  //and set it as the background color
  background(b);
  
  //iterate through columns for x
  for (int x = 0; x < width; x++) {
    //iterate through rows for y
    for (int y = 0; y < height; y++) {
      int pix = x + y*width;           //calculate the pixel location
      color c = img.pixels[pix];       //and grab its color
      
      //calculate z position based on mouseY and brightness of pixel color
      //up (mouseY) and dark (brightness) stay behind; down (mouseY) and bright (brightness) come forward;
      float z = (mouseY/(float)height) * brightness(img.pixels[pix]) - width/2;

      //save default so modifications are reset for each rect
      pushMatrix();
      //translate to x, y, and z
      translate(x, y, z);
      
      //3D scale/size of rect based on mouseX
      //left = zooms out; right = zooms in
      float s = 2*mouseX/(float)width;
      scale(s, s, s);
      
      //fill with pixel color, no stroke, draw the rect at translated (0,0) with width, height = 1
      fill(c);
      noStroke();
      rect(0, 0, 1, 1);
      
      //reset to default
      popMatrix();
    }
  }
}
