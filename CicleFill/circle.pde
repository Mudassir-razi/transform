class Circle
{
  float x, y, r;
  float rate;
  boolean grow;
  Circle(float a, float b, float c)
  {
    x = a;
    y = b;
    r = c;
    rate = 2;
    grow = true;
  }

  void render()
  {
    if(!grow)return;

    noFill();
    strokeWeight(random(1, 6));
    stroke(palette[(int)random(0, paletteSize)]);
    circle(x, y, r);
  }

  void grow()
  {
    boolean valid = true;
    for (int i = 0; i < points.size(); i++)
    {
      Circle other = points.get(i);
      if (other != this) {
        float dis = dist(other.x, other.y, x, y);
        float c2c = r + other.r;
        if (c2c/2 > dis)
        {
          //println(c2c, other.x, other.y, x, y);
          valid = false;
          grow = false;
          break;
        }
      }
    }
    if (valid)
    {
      r += rate;
    }
  }
}
