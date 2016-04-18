// shapes.pde
// utility functions for creating shapes

int getSizeForOffset(int offset) {
  return (int)(offset*2 * altitude);
}


void makeTriangle(int size, int offset) {
  noFill();
  stroke(255);
  int topx = 640;
  int topy = offset;
  int leftx = (int) (640 - (0.5 * size));
  int lefty = (int) (offset + (size * altitude));
  int rightx = (int) (640 + (0.5 * size));
  int righty = lefty;
  triangle(topx,topy,leftx,lefty,rightx,righty);
}

void makeCircle(int size) {
  makeCircle(width/2,height/2,size);
}

void makeCircle(int x, int y, int size) {
  ellipse(x,y,size,size);
}

void makeV(int width, int offset) {
  //PShape v = createShape();
  //v.beginShape(TRIANGLE_STRIP);
  //v.fill(255,255,255);
  //fill(255);
  
  quad(0,640+offset+width,
       0,640+offset,
       640,offset,
       640,offset+width);
  quad(640,offset,
       640,offset+width,
       1280,640+offset+width,
       1280,640+offset);
  //v.vertex(80,720);
  //v.vertex(0,720);
  //v.vertex(640,80);
  //v.vertex(640,160);
  //v.vertex(1280,720);
  //v.vertex(1280,720);
  //v.endShape();
  //return v;
}

float waveDown(int frame, int total) {
  float dist = ((float)frame)/((float)total);
  float amp = cos(dist*PI);
  // turn amplitude from -1 -> 1 to 0 -> 2
  amp += 1.0;
  // divide by 2 to make 0 -> 1
  amp /= 2.0;
  return amp;
}

float waveUp(int frame, int total) {
  float dist = ((float)frame)/((float)total);
  float amp = cos((dist*PI)+PI);
  // turn amplitude from -1 -> 1 to 0 -> 2
  amp += 1.0;
  // divide by 2 to make 0 -> 1
  amp /= 2.0;
  return amp;
}