# Plotter
## Table of Contents
* [About](#About)
* [Overview](#Overview)
* [Improvements](#Improvements)

## About
The goal of this project is to create a large cartesian robot gantry that can draw sidewalk art for an art competition. Currently, the software that converts an image into G-Code is being tested using an Ender 3 V2 3D printer with a 3D printed pen attachment. After the software has reached a point where it is consistently producing good G-Code then I will begin constructing the cartesian robot.

## Overview
Currently, all of the code is written using the Processing.org IDE because its support and libraries for dealing with images and writing files like G-Code made implementing a lot simpler. The way that code works as of now is that it first loads an image that the user selects. After this, it resizes the image based on the point size of the pen and the desired dimensions of the drawn image. After this setup is complete the image is color corrected, since the plotter is currently using colored pens the code changes the color of each pixel in the image to be the same color as the pen that is most similar in color. Now that the image only contains colors that the plotter is able to draw it begins generating the G-Code. The way that it does this is by selecting a color and then scanning the entire image to find any point where that color is on an edge. By doing this we can create a list of edge points for a certain color then by connecting the points that are next to each other using G-Code lines we can draw the outlines of shapes. After an outline of 
a specific color is complete the plotter fills in the shapes again by scanning and finding all pixels of the selected color and drawing lines between those next to each other. If this process is repeated for all colors then the whole image can be drawn. Below are three images, the first image is the original image, the second is the processed image, and the third is the final drawing which is 100mm x 100mm.

![original](https://github.com/JoshCircenis/Plotter/assets/98178221/766132f6-e0ac-4642-8aff-823b268775cc) ![processed](https://github.com/JoshCircenis/Plotter/assets/98178221/4c8b17c0-dc33-4376-abd3-a699645eb310) ![plotted](https://github.com/JoshCircenis/Plotter/assets/98178221/54561d62-d19f-445a-a162-e5123f5769bc)

Comparing the pictures it is clear that there are some issues with the plotter, however, the main issue is that there is play in the 3D printed pen mount which allows the pen to wiggle which is what causes the gaps and inconsistencies. After this test, I decided to do a simpler image and added a rubber band to hold the pen in place. The result of this test is shown below and it is clear that the quality has improved drastically. In this test, because the pen was held still with the rubber band there were significantly fewer gaps between lines however the pen was shifted during the color change which caused the red and blue sections to be slightly misaligned.

![IMG_3195](https://github.com/JoshCircenis/Plotter/assets/98178221/80edc9ea-5d0d-4f48-b512-92c84bea5149)

Below are two time-lapses that show the plotter filling in the contours that it drew.

https://github.com/JoshCircenis/Plotter/assets/98178221/2f21bce7-6d20-4064-aa4e-8b9ea157857b
https://github.com/JoshCircenis/Plotter/assets/98178221/0705cba8-064e-42a2-b8fe-a5bb3d929ae2

## Improvements
Through the testing of this code, several issues have been discovered such as the pen not being locked in place, rough edges, and insignificant points. The issues with the pen not being locked in place or misalignment after switching colors is a problem for the test setup, but in the final design which will be drawing with a pastel paste the colors will switch automatically and the plotter head will be the sole purpose allowing for total precision whereas, in this setup, the pen is attached in a non-permanent 3D printed bracket which is the root of these issues. The next issue is rough edges, this issue stems from the fact that the G-Code is being generated from raster graphics and contains artifacts from this. I am currently working on a solution that will convert from raster to vector using a contour tracing algorithm and De Casteljau's algorithm to represent the contours as perfectly smooth bézier curves. This will give the images a significantly smoother look and should fix this problem. And finally, again because of the raster graphics and the current algorithm, the plotter will attempt to draw single-pixel dots that do not drastically affect the quality of the image and instead waste time. This problem can be solved with noise filtering such as a Gaussian filter, Median filter, or Bilateral filter to eliminate any insignificant single pixels contained within a larger body of pixels while still preserving the overall image.
