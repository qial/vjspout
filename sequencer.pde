// sequencer.pde
// Sequencer interface and classes to easily get sine wave motions

interface Sequencer
{
  float get(int point);
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
  int pulseWidth = 60;
  
  PulseSequencer() {
    // pulses are in a single direction, so always positive
    setPositive(true);
  }
  
  float get(int point) {
    // determine framecount to figure out what range
    // of points are within the pulse
    int pulseFrame = frameCount % pulseLength;
    // pulseFrame is now the current frame along the pulse
    
    // total pulse is the essential number of frames it uses.
    float totalPulse = ((float)pulseLength) + ((float)pulseWidth);
    
    // TODO: calculate conversion rate for pulse location and frame count
    // TODO: return 0 unless point is within pulseWidth/2 of pulse location
    // otherwise calculate using frame location
    
    // at framecount 0, all points should return 0
    // at framecount pulseLength-1 all points except last should return 0
    float framePerPoint = ((float)pulseLength)/((float)points);
    // framePerPoint is the frame distance from each point
    
    // at frame 1 in this default case, point 0 should have some
    // distance and all others should still be zero
    
    // for proof of concept, we're only returning an amount for point 0
    if(point > 0) {
      //return 0;
    }
    
    // determine if the point is in the wave
    float effectiveFrame = pulseFrame + (framePerPoint*point);
    if(effectiveFrame > (pulseWidth)) {
      return 0;
    }
    
    float amt = wave(pulseFrame,pulseWidth);
    return amt;
  }
  
  void setPulseLength(int pulseLength) {
    this.pulseLength = pulseLength;
    recalculate();
  }
  
  // recalculate internal variables
  void recalculate() {
    
  }
}