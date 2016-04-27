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

class EllipseShape implements Shape
{
  int x,y,w,h;
  EllipseShape(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
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