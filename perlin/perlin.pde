int maxPoint = 6000;
float scale = 0.004;
float step = 1;
float rad;
float t;
ArrayList<PVector> prevPoint;
ArrayList<PVector> point;
boolean fade = false;

//interseting seeds - 0, 10, 58, 24, 18, 23
void setup()
{
  fullScreen();
  background(#262626);
  smooth(2);
  noiseSeed(0);
  prevPoint = new ArrayList<PVector>();
  point = new ArrayList<PVector>();
  reset();
  //noLoop();
}

void draw()
{
  stroke(200);
  if (fade)
  {
    fill(0, 3);
    square(0, 0, height);
  }

  for (int i = 0; i < maxPoint; i++)
  {
    PVector curPoint = new PVector(point.get(i).x, point.get(i).y);
    float delX = noise(curPoint.x * scale, 10 * scale) * 2 - 1;
    float delY = noise(10 * scale, curPoint.y * scale) * 2 - 1;
    curPoint.add(new PVector(delX * step, delY * step));
    fill(interpC(#42f57b, #0b2133, t));
    noStroke();
    circle(curPoint.x, curPoint.y, rad);
    point.set(i, curPoint);
  }
  rad -= 0.005;
  t += 0.006;
}

void keyPressed()
{
  reset();
}

void reset()
{
  background(#080808);
  int seed = (int)random(0, 100);
  noiseSeed(seed);
  println(seed);

  rad = 4;
  t = 0;
  point.clear();
  for (int i = 0; i < maxPoint; i++)
  {
    point.add(new PVector(random(0, width), random(0, height)));
  }
}

color interpC(color c1, color c2, float v)
{
  float r = map(v, 0, 1, red(c1), red(c2));
  float g = map(v, 0, 1, green(c1), green(c2));
  float b = map(v, 0, 1, blue(c1), blue(c2));
  return color(r, g, b);
}
