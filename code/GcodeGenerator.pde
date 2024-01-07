ArrayList<String> gcode = new ArrayList<String>();
int currentX = 0;
int currentY = numPixels-1;
int currentDir = 0;
int nextPoint; 
boolean init = false;

void drawEdges(){

  setDrawing(false);
  drawVector2(currentX,currentY,unvisitedEdges.get(0)[0],unvisitedEdges.get(0)[1]);
  currentX = unvisitedEdges.get(0)[0];
  currentY = unvisitedEdges.get(0)[1];
  unvisitedEdges.remove(0);
  
   while(unvisitedEdges.size()!=0){
     if(pointExists(currentX-1,currentY-1)){
        drawEdgeLine(pointIndex(currentX-1,currentY-1));        
     }else if(pointExists(currentX,currentY-1)){       
        drawEdgeLine(pointIndex(currentX,currentY-1));        
     }else if(pointExists(currentX+1,currentY-1)){       
        drawEdgeLine(pointIndex(currentX+1,currentY-1));        
     }else if(pointExists(currentX-1,currentY)){       
        drawEdgeLine(pointIndex(currentX-1,currentY));        
     }else if(pointExists(currentX+1,currentY)){       
        drawEdgeLine(pointIndex(currentX+1,currentY));        
     }else if(pointExists(currentX-1,currentY+1)){       
        drawEdgeLine(pointIndex(currentX-1,currentY+1));        
     }else if(pointExists(currentX,currentY+1)){       
        drawEdgeLine(pointIndex(currentX,currentY+1));        
     }else if(pointExists(currentX+1,currentY+1)){       
        drawEdgeLine(pointIndex(currentX+1,currentY+1));        
     }else{
        int NNIndex = findClosestPoint(currentX, currentY);
        setDrawing(false);
        drawVector2(currentX,currentY, unvisitedEdges.get(NNIndex)[0],unvisitedEdges.get(NNIndex)[1]);
        setDrawing(true);
        currentX=unvisitedEdges.get(NNIndex)[0];
        currentY=unvisitedEdges.get(NNIndex)[1];
        unvisitedEdges.remove(NNIndex);
     }
   }
}

void createGcode(){
  color[] colorPalette = new color[3];
      colorPalette[0] = color(211, 30, 22);
      colorPalette[1] = color(247, 114, 45);
      colorPalette[2] = color(0, 154, 53);

  
  int colorDrawing = colorCode;
  
  startPrint();
  
  boolean notFinished = createEdges(colorPalette[colorDrawing]);
  int i = 0;
  drawEdges();
  
  while(notFinished){
      notFinished = createEdges(colorPalette[colorDrawing]);
      println("Check "+i+" "+unvisitedEdges.size());
      i++;
  }
  drawEdges();
  init = true;

  endPrint();
  gExport();
}
