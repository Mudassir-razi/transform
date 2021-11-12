ArrayList<Rect> rects;
float freq = 0.1;
boolean stopGen;
int maxRects = 800;
int index;
void setup()
{
  fullScreen();
  colorMode(HSB, 360, 100, 100);
  //size(1000, 1000);
  reset();
}

void draw()
{
  int len = rects.size();
  if (len > maxRects)return;
  
  if (index < len) {
    Rect r = rects.get(index);
    r.divide();
    r.render();
  }
  index++;

  //for (int i = 0; i < len; i++)
  //{
  //  Rect r = rects.get(i);
  //  r.divide();
  //  r.render();
  //}
  //delay(100);
}

void keyPressed()
{
  if (key == 'r')reset();
  if (key == 'c')saveFrame();
}

void reset()
{
  rects = new ArrayList<Rect>();
  stopGen = false;
  index = 0;
  createPalette();
  rects.add(new Rect(new PVector(0, 0), new PVector(width, height), 0));
  background(0);
}
