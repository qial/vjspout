//
//          Spout Sender
//
//      Demonstrates drawing onto the Processing
//      screen and sending out as a shared texture
//      to a Spout receiver.
//
//      Based on a Processing example sketch by by Dave Bollinger
//      http://processing.org/examples/texturecube.html
//
//      See Spout.pde for function details
//

// DECLARE A SPOUT OBJECT HERE
Spout spout;

PImage tex;

float altitude = 0.5 * sqrt(3);

SineSequencer seq;

ArrayList<Effect> effects;

// debug display vars
boolean DEBUG = true;
String debugMessage = "";
int debugFrame = 0;
int debugLength = 0;
PFont debugFont;

void setup() {
  // set up basic stuff
  size(1280, 720, P3D);
  frameRate(60);
  strokeWeight(4);
  
  // create font for debug mode messages
  debugFont = createFont("Arial",18,true);
  textFont(debugFont);
  
  // CREATE A NEW SPOUT OBJECT HERE
  spout = new Spout();

  // INITIALIZE A SPOUT SENDER HERE
  spout.initSender("Spout Processing", width, height);
  
  seq = new SineSequencer();
  seq.setSpeed(0.25);
  seq.setPeriod(1);
  
  // set up effects
  effects = new ArrayList<Effect>();
  loadEffects();
} 

void loadEffects() {
  effects.add(new TriangleWave1());
  effects.add(new PulseCircle1());
  // put this line after the default effect
  effects.get(effects.size()-1).setEnabled(true);
  effects.add(new Circles2());
  effects.add(new VDown1());
  effects.add(new VUp1());
  //effects.add(new TriangleWave2());
  //effects.add(new Arrowhead1());
  effects.add(new Rotater1());
  effects.add(new Arrowhead2());
  effects.add(new Diamond3());
  //effects.add(new Diamond2());
  //effects.add(new WatashiMachine1());
  effects.add(new SequencerViewer());
  effects.get(effects.size()-1).toggleAlwaysOn();
}

void draw()  { 
    
  background(0, 0, 0);
  
  // show effects
  for(Effect e : effects) {
    if(e.enabled()) {
      e.play();
    }
  }
  
  //fiveV();
  // Draw something
  //noStroke();
  //translate(width/2.0, height/2.0, -100);
  //rotateX(frameCount * 0.01);
  //rotateY(frameCount * 0.01);      
  //scale(120);
  //TexturedCube(tex);
  //makeTriangle(100,100);
  //makeV(80,80);
  //makeV(80,160);
  //triangleWave(seq);
  //circlePlay1();
  //circlePlay2();
  //diamond1();
  
  drawDebugMessage();
  
  // SEND A SHARED TEXTURE HERE
  spout.sendTexture();
  
}

void drawDebugMessage() {
  if(DEBUG) {
    if(frameCount > debugFrame && 
        frameCount < (debugFrame+debugLength)) {
      fill(255);
      text(debugMessage,10,20);
    }
  }
}

void message(String text) {
  // default length is 2 seconds
  message(text,(int)(frameRate));
}

void message(String text, int frames) {
  debugMessage = text;
  debugFrame = frameCount;
  debugLength = frames;
}

void keyPressed() {
  if(key >= '1' && key <= '9') {
    // enable that effect, remove all other effects
    int idx = key-'1';
    println("Setting effect to "+idx);
    //message("Loaded effect # "+(idx+1)+" "+effects.get(i).getName());
    for(int i = 0; i < effects.size(); i++) {
      if(i == idx) {
        message("Loaded effect "+effects.get(i).name());
        effects.get(i).setEnabled(true);
      } else {
        effects.get(i).setEnabled(false);
      }
    }
  }
  // cancel all effects and turn off always on
  if(key == '0') {
    for(int i = 0; i < effects.size(); i++) {
      if(effects.get(i).alwaysOn()) {
        effects.get(i).toggleAlwaysOn();
      }
      effects.get(i).setEnabled(false);
    }
  }
  // handle setting of always on
  switch(key) {
    case '!': effects.get(0).toggleAlwaysOn(); break;
    case '@': effects.get(1).toggleAlwaysOn(); break;
    case '#': effects.get(2).toggleAlwaysOn(); break;
    case '$': effects.get(3).toggleAlwaysOn(); break;
    case '%': effects.get(4).toggleAlwaysOn(); break;
    case '^': effects.get(5).toggleAlwaysOn(); break;
    case '&': effects.get(6).toggleAlwaysOn(); break;
    case '*': effects.get(7).toggleAlwaysOn(); break;
    case '(': effects.get(8).toggleAlwaysOn(); break;
  }
  // handle debug mode
  if(key == 'v') {
    if(DEBUG) {
      DEBUG = false;
    } else {
      DEBUG = true;
    }
  }
  for(int i = 0; i < effects.size(); i++) {
    if(effects.get(i).enabled() && !effects.get(i).alwaysOn()) {
      println("Sending key '"+key+"' to Effect "+(i+1));
      effects.get(i).handleKey();
    }
  }
}

// over-ride exit to release sharing
void exit() {
  // CLOSE THE SPOUT SENDER HERE
  spout.closeSender();
  super.exit();
} 