class pallete
{
  public color c1;
  public color c2;
  
  color getCol(float min, float max, float val)
  {
    int h = (int)map(val, min, max, hue(c1), hue(c2));
    int s = (int)map(val, min, max, saturation(c1), saturation(c2));
    int b = (int)map(val, min, max, brightness(c1), brightness(c2));
    return color(h, s, b);
  }
}
