ArrayList<Circle> points;
PImage img;
PImage map;
boolean useImage = false;
void setup()
{
  fullScreen();
  //size(800, 800);
  img = loadImage("sample5.png");
  map = createImage(img.width, img.height, RGB);
  println(img.width, img.height);
  for(int x = 0;x < img.width;x++)
  {
    map.loadPixels();
    //img.loadPixels();
    for(int y = 0;y < img.height;y++)
    {
      int loc = x + y * img.width;
      color c = img.pixels[loc];
      float val = (int)(red(c) + blue(c) + green(c))/3;
      map.pixels[loc] = color(val, val, val);
    }
  }
  map.updatePixels();
  reset();
  
}

void draw()
{
  
  //background(255);
  for(int i = 0;i < points.size();i++)
  {
    points.get(i).grow();
    points.get(i).render();
  }
  addNew();
}

void reset()
{
  points = new ArrayList<Circle>();
  background(40);
  //image(map, 0, 0, width, height);
  createPalette();
}

void keyPressed()
{
  if(key == 'r')reset();
}

void addNew()
{
  float x = random(width);
  float y = random(height);
  int xMapped = (int)map(x, 0, width, 0, img.width);
  int yMapped = (int)map(y, 0, height, 0, img.height);
  
  float r = random(20);
  boolean valid = true;
  for(int i = 0;i < points.size();i++)
  {
    Circle c = points.get(i);
    float dis = dist(c.x, c.y, x, y);
    float c2c = r + c.r;
    if(c2c/2 > dis)
    {
      valid = false;
      break;
    }
  }
  
  if(valid)
  {
    Circle cn = new Circle(x, y, r);
    if(useImage)cn.rate = map(red(map.get(xMapped, yMapped)), 0, 255, 0.1, 2);
    points.add(cn);
  }
}
