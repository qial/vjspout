// sequencer.pde
// Sequencer interface and classes to easily get sine wave motions

interface Sequencer
{
  float get(int point);
  int getPoints();
  void setPoints(int points);
}

abstract class AbstractSequencer implements Sequencer
{
  // number of points in set
  // default is 10
  int points = 10;
  
  // if true, range is 0 to 1 instead of -1 to 1
  boolean positive = false;
  
  // recalculate any internal vars
  abstract void recalculate();
  
  int getPoints() {
    return points;
  }
  
  boolean positive() {
    return positive;
  }
  
  void setPoints(int points) {
    this.points = points;
    recalculate();
  }
  
  void setPositive(boolean positive) {
    this.positive = positive;
    // likely nothing to recalculate, but just in case
    recalculate();
  }
}

class SequencerViewer extends ParamEffect
{
  // declaring params
  final String w = "boxWidth";
  final String h = "boxHeight";
  final String a = "amplitude";
  final String m = "multiplier";
  Sequencer seq = new PulseSequencer();
  public SequencerViewer() {
    addParam(w,20);
    addParam(h,20);
    addParam(a,120);
    addParam(m,1);
  }
  void play() {
    // draw the boxes
    noFill();
    for(int i = 0; i < seq.getPoints(); i++) {
      float amt = seq.get(i);
      int offset = round(getParam(a) * amt);
      int x = i*getParam(w)*2;
      int y = height - getParam(h) - offset;
      rect(x,y,getParam(w),getParam(h));
    }
  }
  
}

abstract class PeriodSequencer extends AbstractSequencer
{
  // number of times the period runs over the course of a visual
  int periods = 1;
  
  void setPeriods(int periods) {
    this.periods = periods;
    recalculate();
  }
}

class SineSequencer extends AbstractSequencer
{
  
  // percentage of 2pi the points are over
  // default is 1
  float period = 1.0;
  
  // speed multiplier
  // default speed is a period every measure (once per 2 seconds)
  float speed = 1.0;
  
  // offset, where to start pattern (Expected to be actual number)
  // Only particularly useful for exporting
  float offset = 0.0;
   
  SineSequencer () {
    recalculate();
  }
  
  float get(int point) {
    // get the current point in the pattern
    float x = frameCount * frameSpeed;
    // add offset
    x += periodOffset;
    // add point offset
    x += (pointOffset * point);
    
    if(positive) {
      // convert sign wave to 0-1
      float val = sin(x);
      val += 1;
      val /= 2;
      return (sin(x)+1.0)/2.0;
    }
    return sin(x);
  }
  
  // internal calculated variables
  float periodOffset;
  float pointOffset;
  float frameSpeed;
  
  void recalculate() {
    // period offset is simply where it starts, so 1.0 is 
    periodOffset = offset * PI;
    // point offset is the period length divided by number of points
    // must also convert period length to PI amounts
    pointOffset = (period / points) * TWO_PI;
    // framespeed is how much of a period per frame
    // speed 1.0 = 2*frameRate per period
    // speed 0.5 = frameRate per period
    frameSpeed = (PI / frameRate) * speed;
  }
  
  void setPeriod(float period) {
    this.period = period;
    recalculate();
  }
  
  void setSpeed(float speed) {
    this.speed = speed;
    recalculate();
  }
  
  void setOffset(float offset) {
    this.offset = offset;
    recalculate();
  }
}

class PulseSequencer extends AbstractSequencer
{
  // amount of frames it takes for the pulse to fully travel
  int pulseLength = 60;
  
  // amount of frames the pulse takes to go up and back.
  int pulseWidth = 15;
  
  // internal vars
  float pointWidth = 0.0;
  
  PulseSequencer() {
    // pulses are in a single direction, so always positive
    setPositive(true);
    recalculate();
  }
  
  float get(int point) {
    // determine framecount to figure out what range
    // of points are within the pulse
    int pulseFrame = frameCount % pulseLength;
    // pulseFrame is now the current frame along the pulse
    
    int pointLocation = round(pointWidth * point);
    int pulseStart = round(pulseFrame - (pulseWidth/2.0));
    int pulseEnd = round(pulseFrame + (pulseWidth/2.0));
    println("point="+point
        +" pointw="+pointWidth
        +" pulseFrame="+pulseFrame
        +" position="+pointLocation
        +" pStart="+pulseStart
        +" pEnd="+pulseEnd);
    if(pointLocation >= pulseStart && pointLocation <= pulseEnd) {
      // get distance from pulse start
      float dist = pointLocation-pulseStart;
      // use the wave function
      float amt = wave(dist,pulseWidth);
      println("dist="+dist+" amt="+amt);
      return amt;
    }
    else {
      return 0.0;
    }
    
    
    // total pulse is the essential number of frames it uses.
    //float totalPulse = ((float)pulseLength) + ((float)pulseWidth);
    //float pulseStart = 0.0 - (pulseWidth/2.0);
    // technically we don't need a pulseEnd variable, it ends at pulseLength
    
    // calculate conversion rate for pulse location and frame count
    //float pulseRate = totalPulse / pulseLength;
    
    //float pulseLocation = pulseStart + (pulseFrame * pulseRate); 
    
    // calculate this points position along the pulse
    //float pointLocation = point * pointWidth;
    
    // return 0 unless point is within pulseWidth/2 of pulse location
    //if(pointLocation < (pulseLocation - (pointWidth/2.0)) ||
    //    pointLocation > (pulseLocation + (pointWidth/2.0))) {
      //return 0;
    //}
    
    // we're in the wave, so calculate location
    //float pointInWave = (pointLocation + pulseWidth/2.0) - pulseLocation;
    //println("poL="+pointLocation+"\tpW2="+pulseWidth/2.0+"\tpuL="+pulseLocation+"\tpiW="+pointInWave);
    //float amt = wave(pointInWave,pulseWidth);
    //return amt;
  }
  
  void setPulseLength(int pulseLength) {
    this.pulseLength = pulseLength;
    recalculate();
  }
  
  // recalculate internal variables
  void recalculate() {
    pointWidth = ((float)pulseLength)/((float)points);
  }
}