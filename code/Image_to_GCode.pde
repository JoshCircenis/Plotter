PImage image;
color[][] imageARR;
boolean isSaved = false;

int imageSide = 100; //size of a side of the image mm
float pointSize = 0.3; //size of the drawing tip
int colorCode = 1;
boolean viewable = false;
int numPixels = round(imageSide/pointSize);

void setup() {
  size(0,0);
  image = getScaledImage(numPixels);
  windowResize(image.width,image.height);
  noLoop();
  imageARR = processImage(image);
}

void draw() {
  background(255);
  PImage test = createImageFromColorArray(imageARR);
  image(test, 0, 0);

  // Save the image after it is displayed
  if (!isSaved) {
    PImage quantizedImageToSave = get();
    quantizedImageToSave.save("rt4.jpg");
    isSaved = true;
  }
  createGcode();
}
