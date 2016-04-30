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
  
  setPeriods(int periods) {
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
  
  PulseSequencer() {
    
  }
  
  float get(int point) {
    return 0;
  }
  
  // recalculate internal variables
  void recalculate() {
    
  }
}