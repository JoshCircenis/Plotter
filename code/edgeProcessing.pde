ArrayList<int[]> unvisitedEdges = new ArrayList<int[]>();

boolean createEdges(color drawing){
  color[][] swap = new color[numPixels][numPixels];
  boolean newPoint = false;
  for (int y = 0; y < numPixels; y++) {
      for (int x = 0; x < numPixels; x++) {
          if(!init){swap[x][y] = imageARR[x][y];}
          int yUP = ((y-1) >= 0)? (y-1):y;
          int yDOWN = ((y+1) < imageARR[0].length)? (y+1):y;
          int xBACK = ((x-1) >= 0)? (x-1):x;
          int xFRONT = ((x+1) < imageARR.length)? (x+1):x;
        
          if(imageARR[x][y] == drawing){
            
             if((imageARR[xBACK][y] != drawing)||(xBACK==x)){
               appendPoint(x,y);
               swap[x][y] = color(5,5,5);
             }else if((imageARR[xFRONT][y] != drawing)||(xFRONT==x)){
               appendPoint(x,y);
               swap[x][y] = color(5,5,5);
             }else if((imageARR[x][yUP] != drawing)||(yUP==y)){
               appendPoint(x,y);
               swap[x][y] = color(5,5,5);
             }else if((imageARR[x][yDOWN] != drawing)||(yDOWN==y)){
               appendPoint(x,y);
               swap[x][y] = color(5,5,5);
             }
             newPoint = true;
          }
      }
  }
  for (int y = 0; y < numPixels; y++) {
      for (int x = 0; x < numPixels; x++) {
          imageARR[x][y] = swap[x][y];
      }
  }
  return newPoint;
}

void appendPoint(int x, int y){
  int[] pointElement = {x,y};
  if(!(pointExists(x,y))){
    unvisitedEdges.add(pointElement);
  }
}

void deletePoint(int x, int y){
  if(pointExists(x,y)){
    unvisitedEdges.remove(pointIndex(x,y));
  }
}

boolean pointExists(int x, int y){
  for (int i = 0; i < unvisitedEdges.size(); i++) {
      if((unvisitedEdges.get(i)[0]==x)&&(unvisitedEdges.get(i)[1]==y)){
        return true;
      }
  }
  return false;
}

int pointIndex(int x, int y){
  for (int i = 0; i < unvisitedEdges.size(); i++) {
      if((unvisitedEdges.get(i)[0]==x)&&(unvisitedEdges.get(i)[1]==y)){
        return i;
      }
  }
  return -1;
}
