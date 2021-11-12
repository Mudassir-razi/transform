PImage img;
float contrast = 0.5;

ArrayList<PVector> points;
int maxPoints = 2000;

void setup()
{
  size(800, 800);
  img = loadImage("white.png");
  points = new ArrayList<PVector>();
  reset();
  grey();
  contrast();
  background(0);
  println(tan(PI/2));
  //image(img, 0, 0);
}

void draw()
{
  //image(img, 0, 0);
  //noStroke();
  for (int i = 0; i < maxPoints; i++)
  {
    PVector dir; //= new PVector(random(-1, 1), random(-1, 1)).normalize();
    PVector pos = points.get(i);
    PVector newPos = new PVector(pos.x, pos.y);
    color c = img.get((int)pos.x, (int)pos.y);
    float step = 25;
    float slope = atan(map(red(c), 0, 255, -1, 1));

    if (blue(c) < 255/6)blendMode(MULTIPLY);
    else blendMode(NORMAL);

    dir = new PVector(cos(slope), sin(slope));
    newPos.add(dir.mult(step));
    noStroke();
    stroke(200, red(c));
    line(pos.x, pos.y, newPos.x, newPos.y);
    points.set(i, newPos);
  }
}

void reset()
{
  for (int i = 0; i < maxPoints; i++)
  {
    PVector pos = new PVector(random(0, width), random(0, height));
    points.add(pos);
  }
}

void grey()
{
  img.loadPixels();
  for (int x = 0; x < img.width; x++)
  {
    for (int y = 0; y < img.height; y++)
    {
      color c = img.get(x, y);
      float val = red(c) + blue(c) + green(c);
      val = val / 3;
      img.set(x, y, color(val, val, val));
    }
  }
  img.updatePixels();
}

void contrast()
{
  img.loadPixels();
  for (int x = 0; x < img.width; x++)
  {
    for (int y = 0; y < img.height; y++)
    {
      color c = img.get(x, y);
      float val = red(c);
      if (val < 255/2)
      {
        val -= contrast * val;
      } else
      {
        val += contrast * val;
      }
      val = constrain(val, 0, 255);
      img.set(x, y, color(val, val, val));
    }
  }
  img.updatePixels();
}
