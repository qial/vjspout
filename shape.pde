// shape.pde
// Shape interface and attempt to develop a better API for effects

interface Shape
{
  void paint();
}

class RectShape implements Shape
{
  int x,y,w,h;
  RectShape(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void paint() {
    rect(x,y,w,h);
  }
}

class SquareShape extends RectShape
{
  SquareShape(int x, int y, int s) {
    super(x,y,s,s);
  }
}

class EllipseShape extends RectShape
{
  EllipseShape(int x, int y, int w, int h) {
    super(x,y,w,h);
  }
  void paint() {
    ellipse(x,y,w,h);
  }
}

class CircleShape extends EllipseShape
{
  CircleShape(int x, int y, int r) {
    super(x,y,r*2,r*2);
  }
}

class VShape implements Shape
{
  int w,int o;
  VShape(int w, int offset) {
    this.w = w;
    this.o = offset;
  }
  void paint() {
    makeV(w,o);
  }
}

class DiamondShape extends RectShape
{
  DiamondShape(int x, int y, int w, int h) {
    super(x,y,w,h);
  }
  void paint() {
    // reimplement paint to just make a diamond
  }
}

// For shapes like the V, maybe I need a way to define a 
// movement of some sort. That movement could be distance
// in the case of the Vs, or size in the case of circles.
// Movement could even be both, just an abstraction of 
// size and position movements. Each shape can decide how
// exactly to handle size or position changes defined by
// the movements.