// effects.pde
// The Effect interface and effect classes

interface Effect
{
  String name();
  void play();
  void handleKey();
  void setEnabled(boolean enabled);
  boolean enabled();
}

abstract class SimpleEffect implements Effect
{
  String name() {
    return getClass().getName();
  }
  boolean enabled = false;
  void setEnabled(boolean enabled) {
    this.enabled = enabled;
  }
  boolean enabled() {
    return enabled;
  }
  void handleKey() {}
  abstract void play();
}

abstract class ParamEffect extends SimpleEffect
{
  ArrayList paramNames = new ArrayList();
  HashMap params = new HashMap();
  void addParam(String name, int initialValue) {
    paramNames.add(name);
    params.put(name,initialValue);
  }
  void setParam(String name, float val) {
    params.put(name,val);
  }
  int getParam(String name) {
    return (int)params.get(name);
  }
  void handleKey() {
    println("gotkey "+key);
    switch(key) {
      case 'q': incParam(0);break;
      case 'Q': incParamAmt(0);break;
      case 'a': decParam(0);break;
      case 'A': decParamAmt(0);break;
      case 'w': incParam(1);break;
      case 'W': incParamAmt(1);break;
      case 's': decParam(1);break;
      case 'S': decParamAmt(1);break;
      case 'e': incParam(2);break;
      case 'E': incParamAmt(2);break;
      case 'd': decParam(2);break;
      case 'D': decParamAmt(2);break;
      case 'r': incParam(3);break;
      case 'R': incParamAmt(3);break;
      case 'f': decParam(3);break;
      case 'F': decParamAmt(3);break;
    }
  }
  private void incParam(int num) {
    println("incParam: "+num);
    String param = (String)paramNames.get(num);
    int v = (int)params.get(param);
    v+= 1;
    message(param+" = "+v);
    params.put(param,v);
  }
  private void decParam(int num) {
    println("decParam: "+num);
    String param = (String)paramNames.get(num);
    int v = (int)params.get(param);
    v-=1;
    message(param+" = "+v);
    params.put(param,v);
  }
  private void incParamAmt(int num) {
    println("incParamAmt: "+num);
    // TODO make this change amount instead of just +5
    String param = (String)paramNames.get(num);
    int v = (int)params.get(param);
    v+=5;
    message(param+" = "+v);
    params.put(param,v);
  }
  private void decParamAmt(int num) {
    println("decParamAmt: "+num);
    // TODO make this change amount instead of just +5
    String param = (String)paramNames.get(num);
    int v = (int)params.get(param);
    v-=5;
    message(param+" = "+v);
    params.put(param,v);
  }
}

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