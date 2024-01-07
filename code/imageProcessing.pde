/*    
      color[] colorPalette = new color[15];
      colorPalette[0] = color(255, 255, 255);
      colorPalette[1] = color(232, 86, 112);
      colorPalette[2] = color(211, 30, 22);
      colorPalette[3] = color(247, 114, 45);
      colorPalette[4] = color(250, 169, 32);
      colorPalette[5] = color(136, 188, 0);
      colorPalette[6] = color(0, 154, 53);
      colorPalette[7] = color(0, 123, 129);
      colorPalette[8] = color(19, 152, 185);
      colorPalette[9] = color(65, 86, 126);
      colorPalette[10] = color(43, 50, 142);
      colorPalette[11] = color(111, 48, 129);
      colorPalette[12] = color(216, 5, 114);
      colorPalette[13] = color(75, 40, 0);
      colorPalette[14] = color(0, 0, 0);
      
      color[] colorPalette = new color[8];
      colorPalette[0] = color(0, 0, 0);
      colorPalette[1] = color(255, 255, 255);
      colorPalette[2] = color(255, 0, 0);
      colorPalette[3] = color(0, 255, 0);
      colorPalette[4] = color(0, 0, 255);
      colorPalette[5] = color(255, 255, 0);
      colorPalette[6] = color(0, 255, 255);
      colorPalette[7] = color(255, 0, 255);
      
      color[] colorPalette = new color[24];
      colorPalette[0] = color(138, 230, 95);
      colorPalette[1] = color(71, 112, 94);
      colorPalette[2] = color(85, 128, 119);
      colorPalette[3] = color(62, 141, 174);
      colorPalette[4] = color(164, 241, 249);
      colorPalette[5] = color(89, 183, 219);
      colorPalette[6] = color(69, 87, 123);
      colorPalette[7] = color(72, 59, 103);
      colorPalette[8] = color(59, 84, 168);
      colorPalette[9] = color(92, 75, 67);
      colorPalette[10] = color(116, 119, 126);
      colorPalette[11] = color(39, 39, 39);
      colorPalette[12] = color(252, 254, 253);
      colorPalette[13] = color(255, 238, 136);
      colorPalette[14] = color(252, 235, 181);
      colorPalette[15] = color(247, 255, 46);
      colorPalette[16] = color(249, 215, 29);
      colorPalette[17] = color(248, 134, 48);
      colorPalette[18] = color(248, 63, 68);
      colorPalette[19] = color(200, 108, 57);
      colorPalette[20] = color(158, 70, 66);
      colorPalette[21] = color(217, 85, 135);
      colorPalette[22] = color(205, 43, 119);
      colorPalette[23] = color(205, 43, 119);
*/
String path;
boolean complete = false;
  
color findClosestColor(color targetColor) {
      color[] colorPalette = new color[3];
      colorPalette[0] = color(211, 30, 22);
      colorPalette[1] = color(247, 114, 45);
      colorPalette[2] = color(0, 154, 53);
      
      int closestIndex = 0;
      float closestDist = dist(red(targetColor), green(targetColor), blue(targetColor), red(colorPalette[0]), green(colorPalette[0]), blue(colorPalette[0]));
      
      for (int i = 1; i < colorPalette.length; i++) {
        float d = dist(red(targetColor), green(targetColor), blue(targetColor), red(colorPalette[i]), green(colorPalette[i]), blue(colorPalette[i]));
        if (d < closestDist) {
          closestDist = d;
          closestIndex = i;
        }
      }
      
      return colorPalette[closestIndex];
}

PImage getScaledImage(int sideLength){
  PImage image;
  selectInput("Select a file to process:", "fileSelected");
  while(!complete){println("Waiting...");}
  image = loadImage(path);
  image.resize(sideLength, sideLength);
  return image;
}

void fileSelected(File selection) {
  path = selection.getAbsolutePath();
  complete = true;
}

color[][] processImage(PImage unprocessedImg){
    color[][] processedImg = new color[unprocessedImg.width][unprocessedImg.height];
    
    for (int y = 0; y < unprocessedImg.height; y++) {
      for (int x = 0; x < unprocessedImg.width; x++) {
          processedImg[x][y] = findClosestColor(unprocessedImg.get(x,y));
      }
    }
    return processedImg;
}

PImage createImageFromColorArray(color[][] colorArray) {
  int arrWidth = colorArray.length;
  int arrHeight = colorArray[0].length;

  PImage img = createImage(arrWidth, arrHeight, RGB);

  // Copy the color data from the colorArray to the image's pixels
  img.loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + (y * width);
      img.pixels[index] = colorArray[x][y];
    }
  }
  img.updatePixels();

  return img;
}
