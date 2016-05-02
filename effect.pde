// effect.pde
// The Effect interface and utility Effect classes

interface Effect
{
  String name();
  void play();
  void handleKey();
  void setEnabled(boolean enabled);
  boolean enabled();
  void toggleAlwaysOn();
  boolean alwaysOn();
}

abstract class SimpleEffect implements Effect
{
  boolean enabled = false;
  void setEnabled(boolean enabled) {
    this.enabled = enabled;
  }
  boolean enabled() {
    if(alwaysOn) {
      return true;
    }
    return enabled;
  }
  boolean alwaysOn = false;
  void toggleAlwaysOn() {
    if(alwaysOn) {
      alwaysOn = false;
    } else {
      alwaysOn = true;
    }
  }
  boolean alwaysOn() {
    return alwaysOn;
  }
  String name() {
    return getClass().getName();
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
      case 't': incParam(4);break;
      case 'T': incParamAmt(4);break;
      case 'g': decParam(4);break;
      case 'G': decParamAmt(4);break;
      case 'y': incParam(5);break;
      case 'Y': incParamAmt(5);break;
      case 'h': decParam(5);break;
      case 'H': decParamAmt(5);break;
    }
  }
  private void incParam(int num) {
    if(num >= paramNames.size()) return;
    println("incParam: "+num);
    String param = (String)paramNames.get(num);
    int v = (int)params.get(param);
    v+= 1;
    message(param+" = "+v);
    params.put(param,v);
  }
  private void decParam(int num) {
    if(num >= paramNames.size()) return;
    println("decParam: "+num);
    String param = (String)paramNames.get(num);
    int v = (int)params.get(param);
    v-=1;
    message(param+" = "+v);
    params.put(param,v);
  }
  private void incParamAmt(int num) {
    if(num >= paramNames.size()) return;
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
    if(num >= paramNames.size()) return;
    // TODO make this change amount instead of just +5
    String param = (String)paramNames.get(num);
    int v = (int)params.get(param);
    v-=5;
    message(param+" = "+v);
    params.put(param,v);
  }
}

class StreamEffect extends SimpleEffect
{
  ArrayList<Rectangle> cams;
  Rectangle gameOuter;
  Rectangle gameInner;
  StreamEffect() {
    cams = new ArrayList<Rectangle>();
  }
  void setOuter(Rectangle outer) {
    this.gameOuter = outer;
  }
  void setInner(Rectangle inner) {
    this.gameInner = inner;
  }
  void addCam(Rectangle cam) {
    cams.add(cam);
  }
  void play() {
    background(255);
    noStroke();
    fill(0);
    for(Rectangle r : cams) {
      rect(r.x,r.y,r.w,r.h);
    }
    fill(0);
    rect(gameOuter.x,gameOuter.y,gameOuter.w,gameOuter.h);
  }
}

class Rectangle
{
  int x,y,h,w;
  Rectangle(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
  }
}