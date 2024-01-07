void gExport() {
  //Create a unique name for the exported file
  //String name_save = "gcode_"+day()+""+hour()+""+minute()+"_"+second()+".gcode";
  String name_save = "geo"+colorCode+".gcode";
  
  //Convert from ArrayList to array (required by saveString function)
  String[] arr_gcode = gcode.toArray(new String[gcode.size()]);
  
  //Export
  saveStrings(name_save, arr_gcode);
  println("*****DONE*****");
}

void startPrint(){
  gCommand(";Startup sequence");
  gCommand("M107");//turn off fan
  gCommand("M104 S0");//turn off hotend
  gCommand("M140 S0");//turn off heated bed
  gCommand("M82");//absolute extrusion
  gCommand("G92 E0");//Reset extruder
  
  gCommand("G28");//home all axes
  gCommand("G1 F2700");//set speed to 45mm/s
  setDrawing(false);//lift hotend
  gCommand("G1 X40 Y20");//move to start
  gCommand("G91");//set relative positioning
  gCommand(";Printing");
}
 
void endPrint(){
  gCommand(";End sequence");
  setDrawing(false);
  gCommand("G90");//absolute positioning
  gCommand("G1 X0 Y235");//present print
  gCommand("M106 S0");//turn off fan
  gCommand("M104 S0");//turn off hotend
  gCommand("M140 S0");//turn off heated bed
  gCommand("M84 X Y E");//disable all steppers but Z
  gCommand("M82");//absolute extrusion
  gCommand("M104 S0");//set hotend zero again because it did in the cura gcode
}

void setDrawing(boolean drawing){
  int up = 17;
  float down = 14.5;
  gCommand("G90");//set absolute positioning
  if(drawing){
    gCommand("G1 Z"+down);//set pen to contact bed
  }else{
    gCommand("G1 Z"+up);//set pen to lift from bed
  }
  gCommand("G91");//set relative positioning
}

void drawVector(int x1, int y1, int x2, int y2){
  if(viewable){
   gCommand("G1 E5 X"+(((x2)-x1)*pointSize)+" Y"+(((y2)-y1)*-pointSize)); //draw a line of length distance in direction -1 or 1
  }else{
    gCommand("G1 X"+(((x2)-x1)*pointSize)+" Y"+(((y2)-y1)*-pointSize)); //draw a line of length distance in direction -1 or 1
  }
}

void drawVector2(int x1, int y1, int x2, int y2){
   gCommand("G1 X"+(((x2)-x1)*pointSize)+" Y"+(((y2)-y1)*-pointSize)); //draw a line of length distance in direction -1 or 1
}

void gCommand(String command) {
 gcode.add(command);
}

void drawEdgeLine(int index){
  setDrawing(true);
  drawVector(currentX,currentY,unvisitedEdges.get(index)[0],unvisitedEdges.get(index)[1]);
  currentX=unvisitedEdges.get(index)[0];
  currentY=unvisitedEdges.get(index)[1];
  unvisitedEdges.remove(index);
}

int findClosestPoint(int x, int y){
      int closestIndex = 0;
      float closestDist = dist(x,y,unvisitedEdges.get(0)[0],unvisitedEdges.get(0)[1]);
      
      for (int i = 1; i < unvisitedEdges.size(); i++) {
        float d = dist(x,y,unvisitedEdges.get(i)[0],unvisitedEdges.get(i)[1]);
        if (d < closestDist) {
          closestDist = d;
          closestIndex = i;
        }
      }
      
      return closestIndex;
}
