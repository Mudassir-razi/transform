
float cnst = 0.008;

//renderings
boolean stroke = true;
boolean fill = false;
boolean square = false;
int inside = 50;
int palleteSize = 5;
float offset = 4;
color colStroke = #0D0D0D;


class Rect
{
  PVector p1, p2;
  PVector dir;
  float divProb;
  int gen;
  boolean dead;
  boolean doneRender;

  Rect(PVector a, PVector b, int g)
  {
    p1 = a;
    p2 = b;
    dead = false;
    doneRender = false;
    gen = g;
    divProb = exp(-gen * cnst);
  }

  void render()
  {
    if(doneRender)return;
    noFill();
    if (fill)fill(palette[(int)random(0, palleteSize)]);
    strokeWeight(map(divProb, 0, 1, 0.1, 1.5));
    noStroke();

    for (int i = 0; i < inside; i++) {
      strokeWeight(random(1, 6));
      if (stroke)stroke(palette[(int)random(0, palleteSize)], 255);
      float red = i * offset;
      float w = p2.x - p1.x;
      float h = p2.y - p1.y;
      if (red > h || red > w)return;
      else rect(p1.x + red, p1.y + red, w - 2 * red, h - 2 * red);
    }
    doneRender = true;
    //blendMode(MULTIPLY);
    //image(noise, p1.x, p1.y, p2.x - p1.x, p2.y - p1.y);
  }

  void divide()
  {
    if (dead)return;
    float val = random(0, 1);
    if (val <= divProb) {
      float t = random(0.2, 1);    //amount with which it's gonna move
      if (square)t = 0.5;
      float hov = random(0, 1);  //horizontal or vertical?

      PVector np1, np2;
      //then divide it horizontally
      if (hov < 0.5)
      {
        np1 = new PVector(p2.x, map(t, 0, 1, p1.y, p2.y));
        np2 = new PVector(p1.x, map(t, 0, 1, p1.y, p2.y));
      } else 
      {
        np1 = new PVector(map(t, 0, 1, p1.x, p2.x), p2.y);
        np2 = new PVector(map(t, 0, 1, p1.x, p2.x), p1.y);
      }

      Rect r1 = new Rect(p1, np1, gen+1);
      Rect r2 = new Rect(np2, p2, gen+1);
      rects.add(r1);
      rects.add(r2);
    }
    dead = true;
  }
}
