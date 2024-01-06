# Plotter
## Table of Contents
* [About](#About)
* [Overview](#Overview)
* [Improvements](#Improvements)

## About
The goal of this project is to create a large cartesian robot gantry that can draw sidewalk art for an art competition. Currently the software that converts an image into G-Code is being tested using an Ender 3 V2 3D printer with a 3D printed pen attachment. After the software has reached a point where it is consistently producing good G-Code then I will begin constructing the cartesian robot.

## Overview
Currently all of the code is written using the Processing.org IDE because its support and libraries for dealing with images and writing files like G-Code made implementing a lot simpler. The way that code works as of now is that it first loads an image that the user selects. After this it resizes the image based on the point size of the pen and the desired dimensions of the drawn image. After this setup is complete the image is color corrected, since the plotter is currently using colored pens the code changes the color of each pixel in the image to be the same color as the pen that is most similar in color. Now that the image only contains colors that the plotter is able to draw it begins generating the G-Code. The way that it does this is by selecting a color then scaning the entire image to find any point where that color is on an edge. By doing this we can create a list of edge points for a certain color then by connecting the points that are next to each other using G-Code lines we can draw the outlines of shapes. After an outline of a color is complete the plotter fills in the shapes again by scanning and finding all pixels of the selected color and drawing lines between those next to eachother. If this process is repeated for all colors then the whole image can be drawn. Below are three images, the image on the far left is the original image, the image in the middle is the processed image, and the image on the right is the final drawing which is 100mm x 100mm.

![original](https://github.com/JoshCircenis/Plotter/assets/98178221/766132f6-e0ac-4642-8aff-823b268775cc) ![processed](https://github.com/JoshCircenis/Plotter/assets/98178221/4c8b17c0-dc33-4376-abd3-a699645eb310) ![plotted](https://github.com/JoshCircenis/Plotter/assets/98178221/54561d62-d19f-445a-a162-e5123f5769bc)



## Improvements
