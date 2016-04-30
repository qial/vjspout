// effects.pde
// Effect implementations

class Diamond1 extends ParamEffect
{
  String amt = "shapes";
  String inc = "spacing";
  String amp = "amplitude";
  String start = "size";
  Diamond1() {
    // set up params
    addParam(amt,10);
    addParam(inc,28);
    addParam(amp,18);
    addParam(start,80);
  }
  void play() {
    stroke(255);
    noFill();
    // num of shapes
    //int amt = 10;
    // distance between shapes
    //int inc = 28;
    // size of motion
    //int amp = 18;
    // min shape size
    //int start = 80;
    // width ratio
    float ratio = 1.6;
    for(int i = 0; i < getParam(amt); i++) {
      float s = seq.get(i)*getParam(amp);
      int bottom_x = (width/2);
      int bottom_y = (height/2)+getParam(start)+(i*getParam(inc));
      int right_x = (width/2)+((int)(getParam(start)*ratio))+((int)(i*getParam(inc)*ratio));
      int right_y = (height/2);
      int top_x = (width/2);
      int top_y = (height/2)-getParam(start)-(i*getParam(inc));
      int left_x = (width/2)-((int)(getParam(start)*ratio))-((int)(i*getParam(inc)*ratio));
      int left_y = (height/2);
      quad(bottom_x,bottom_y+s,right_x+s,right_y,top_x,top_y-s,left_x-s,left_y);
    }
  }
}

class Diamond3 extends ParamEffect
{
  String amt = "shapes";
  String inc = "spacing";
  String amp = "amplitude";
  String start = "start";
  Diamond3() {
    // set up params
    addParam(amt,10);
    addParam(inc,28);
    addParam(amp,18);
    addParam(start,2);
  }
  void play() {
    stroke(255);
    noFill();
    // num of shapes
    //int amt = 10;
    // distance between shapes
    //int inc = 28;
    // size of motion
    //int amp = 18;
    // min shape size
    //int start = 80;
    // width ratio
    float ratio = 1.6;
    for(int i = getParam(start); i < getParam(amt); i++) {
      float s = seq.get(i)*getParam(amp);
      int bottom_x = (width/2);
      int bottom_y = (height/2)+(i*getParam(inc));
      int right_x = (width/2)+((int)(i*getParam(inc)*ratio));
      int right_y = (height/2);
      int top_x = (width/2);
      int top_y = (height/2)-(i*getParam(inc));
      int left_x = (width/2)-((int)(i*getParam(inc)*ratio));
      int left_y = (height/2);
      quad(bottom_x,bottom_y+s,right_x+s,right_y,top_x,top_y-s,left_x-s,left_y);
    }
  }
}

class VDown extends SimpleEffect
{
  void play() {
    fill(255);
    stroke(255);
    for(int i = 1; i < 10; i++){
      int off = 120*i;
      off += frameCount%120;
      makeV(60,off);
    }
  }
}

class VDown1 extends SimpleEffect
{
  void play() {
    stroke(255);
    for(int i = 0; i < 6; i++){
      if(i == 0) {
        float opacity = 255.0/120.0;
        int frameAmt = frameCount%120;
        
        int alpha = (int) (255.0 * (waveUp(frameAmt,120)));
        stroke(alpha);
        fill(alpha);
      } else {
        stroke(255);
        fill(255);
      }
      int off = 120*i;
      off += frameCount%120;
      makeV(60,off+30);
    }
  }
}

class VUp1 extends SimpleEffect
{
  void play() {
    stroke(255);
    for(int i = 0; i < 6; i++){
      if(i == 0) {
        float opacity = 255.0/120.0;
        int frameAmt = frameCount%120;
        
        int alpha = (int) (255.0 * (waveDown(frameAmt,120)));
        stroke(alpha);
        fill(alpha);
      } else {
        stroke(255);
        fill(255);
      }
      int off = 120*i;
      off -= frameCount%120;
      makeV(60,off+150);
    }
  }
}

class VUp2 extends ParamEffect
{
  String amt = "shapes";
  String w = "width";
  String inc = "spacing";
  String fade = "fade";
  //String amp = "amplitude";
  //String start = "start";
  VUp2() {
    // set up params
    addParam(amt,4);
    addParam(w,60);
    addParam(inc,60);
    addParam(fade,60);
    //addParam(amp,18);
    //addParam(start,2);
  }
  void play() {
    stroke(255);
    for(int i = 0; i < 6; i++){
      if(i == 0) {
        float opacity = 255.0/120.0;
        int frameAmt = frameCount%120;
        
        int alpha = (int) (255.0 * (waveDown(frameAmt,120)));
        stroke(alpha);
        fill(alpha);
      } else {
        stroke(255);
        fill(255);
      }
      int off = 120*i;
      off -= frameCount%120;
      makeV(60,off+150);
    }
  }
}

class Rotater1 extends ParamEffect
{
  String amt = "shapes";
  String inc = "spacing";
  String amp = "amplitude";
  String start = "size";
  Rotater1() {
    // set up params
    addParam(amt,10);
    addParam(inc,28);
    addParam(amp,18);
    addParam(start,80);
  }
  void play() {
    
    for(int i = 0; i < 10; i++) {
      int size = getParam(start)+(i*getParam(inc)); 
      //rect(
      //rotate(
    }
  }
}

class Circles1 extends SimpleEffect
{
  void play() {
    fill(255);
    stroke(0);
    for(int i = 0; i < 20; i++) {
      float s = seq.get(i);
      int offset = i*35 + (int)(s * 30);
      makeCircle(offset);
    }
  }
}

class Circles2 extends SimpleEffect
{
  void play() {
    noFill();
    stroke(255);
    for(int i = 0; i < 20; i++) {
      float s = seq.get(i);
      int offset = i*35 + (int)(s * 30);
      makeCircle(offset);
      //makeTriangle(100+getSizeForOffset(offset),360-offset);
    }
  }
}

class TriangleWave1 extends ParamEffect
{
  String amt = "shapes";
  String inc = "spacing";
  String amp = "amplitude";
  String start = "size";
  TriangleWave1() {
    // set up params
    addParam(amt,10);
    addParam(inc,28);
    addParam(amp,18);
    addParam(start,80);
  }
  void play() {
    for(int i = 0; i < getParam(amt); i++) {
      float s = seq.get(i);
      int offset = i*20 + (int)(s*20);
      makeTriangle(100+getSizeForOffset(offset),360-offset);
    }
    //for(int i = 1; i < 10; i++) {
    //  float s = seq.get(9-i);
    //  int offset = i*20 + (int)(s * 20);
    //  makeTriangle(100+getSizeForOffset(offset),360-offset);
    //}
  }
}

class TriangleWave2 extends SimpleEffect
{
  void play() {
    float amt = sin(frameCount/60.0)*30;
    for(int i = 1; i < 20; i++) {
      makeTriangle((int)(100+(amt * i)),100*i);
    }
  }
}



class Arrowhead1 extends SimpleEffect
{
  void play() {
    stroke(255);
    noFill();
    // num of shapes
    int amt = 10;
    // distance between shapes
    int inc = 30;
    // size of motion
    int amp = 20;
    // min shape size
    int start = 90;
    // width ratio
    float ratio = 1.25;
    for(int i = 0; i < amt; i++) {
      float s = seq.get(i)*amp;
      int bottom_x = (width/2);
      int bottom_y = (height/2)+start+(i*inc);
      int right_x = (width/2)+((int)((start+(i*inc))*ratio));
      int right_y = (height/2);
      int top_x = (width/2);
      int top_y = (height/2)-start-(i*inc);
      int left_x = (width/2)-((int)((start-(i*inc))*ratio));
      int left_y = (height/2);
      quad(bottom_x,bottom_y+s,right_x+s,right_y,top_x,top_y-s,left_x-s,left_y);
      
    }
  }
}

class Arrowhead2 extends SimpleEffect
{
  void play() {
    stroke(255);
    noFill();
    // num of shapes
    int amt = 10;
    // distance between shapes
    int inc = 30;
    // size of motion
    int amp = 20;
    // min shape size
    int start = 90;
    // width ratio
    float ratio = 1.25;
    for(int i = 0; i < amt; i++) {
      float s = seq.get(i)*amp;
      int bottom_x = (width/2);
      int bottom_y = (height/2)+start+(i*inc);
      int right_x = (width/2)-((int)((start+(i*inc))*ratio));
      int right_y = (height/2);
      int top_x = (width/2);
      int top_y = (height/2)-start-(i*inc);
      int left_x = (width/2)+((int)((start+(i*inc))*ratio));
      int left_y = (height/2);
      quad(bottom_x,bottom_y+s,right_x+s,right_y,top_x,top_y-s,left_x-s,left_y);
      
    }
  }
}

class Diamond2 extends SimpleEffect
{
  void play() {
    stroke(255);
    noFill();
    // num of shapes
    int amt = 10;
    // distance between shapes
    int inc = 30;
    // size of motion
    int amp = 20;
    // min shape size
    int start = 90;
    // width ratio
    float ratio = 1.25;
    for(int i = 0; i < amt; i++) {
      float s = seq.get(i)*amp;
      int bottom_x = (width/2);
      int bottom_y = (height/2)+start+(i*inc);
      int right_x = (width/2)-((int)((start+(i*inc))*ratio));
      int right_y = (height/2);
      int top_x = (width/2);
      int top_y = (height/2)-start-(i*inc);
      int left_x = (width/2)+((int)((start+(i*inc))*ratio));
      int left_y = (height/2);
      quad(bottom_x,bottom_y+s,right_x+s,right_y,top_x,top_y-s,left_x-s,left_y);
      
    }
  }
}

class WatashiMachine1 extends StreamEffect
{
  WatashiMachine1() {
    // this one is nearly exact
    //addCam(new Rectangle(0,530,250,180));
    // this one doesn't cover up the white
    addCam(new Rectangle(0,522,248,195));
    // nearly exact
    //setOuter(new Rectangle(300,44,960,600));
    // for ff9
    setOuter(new Rectangle(315,44,915,600));
    setInner(new Rectangle(335,64,875,560));
  }
}

class PulseCircle1 extends ParamEffect
{
  Sequencer seq = new PulseSequencer();
  
  String amt = "shapes";
  String inc = "spacing";
  String amp = "amplitude";
  String skip = "skip";
  PulseCircle1() {
    // set up params
    addParam(amt,5);
    addParam(inc,100);
    addParam(amp,40);
    addParam(skip,3);
  }
  void play() {
    stroke(255);
    noFill();
    for(int i = 0; i < getParam(amt); i++) {
      float offset = i * getParam(inc);
      float movement = seq.get(i) * getParam(amp);
      int circle = (int) (600 - offset - movement);
      makeCircle(circle);
    }
  }
}