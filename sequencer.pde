// sequencer.pde
// Sequencer interface and classes to easily get sine wave motions

interface Sequencer
{
  float get(int point);
}

class SineSequencer implements Sequencer
{
  // number of points in set
  // default is 10
  int points = 10;
  
  // percentage of 2pi the points are over
  // default is 1
  float period = 1.0;
  
  // speed multiplier
  // default speed is a period every measure (once per 2 seconds)
  float speed = 1.0;
  
  // if true, range is 0 to 1 instead of -1 to 1
  boolean positive = false;
  
  // offset, where to start pattern (Expected to be actual number)
  // Only particularly useful for exporting
  float offset = 0.0;
   
  Sequencer () {
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
  
  void setPoints(int points) {
    this.points = points;
    recalculate();
  }
  
  void setPeriod(float period) {
    this.period = period;
    recalculate();
  }
  
  void setPositive(boolean positive) {
    this.positive = positive;
    // nothing to recalculate, this only changes what we output
    //recalculate();
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