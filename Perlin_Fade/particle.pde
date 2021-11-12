class Particle
{
  PVector pos;
  color c;
  float rad;
  float rate;
  float initrad;

  Particle(PVector p, color col, float r)
  {
    pos = p;  
    c = col;
    initRad = r;
    rate = random(radRedRate/2, radRedRate);
  }

  void update()
  {
    PVector curPoint = new PVector(pos.x, pos.y);
    float delX = noise(curPoint.x * scale + offsetX) * 2 - 1;
    float delY = noise(offsetY + curPoint.y * scale) * 2 - 1;
    pos.add(delX * step, delY * step);
    rad -= rate;
    if(rad <= minRad)rad = minRad;
    if(rad >= maxRad)rad = maxRad;
    if(randomGen)
    {
      float val = random(0, 1);
      if(val < 0.01)reset();
    }
  }
  
  void setColorFromPic()
  {
    c = img.get((int)pos.y, (int)pos.x);
  }
  
  void render()
  {
    color col = c;
    if (pic)
    {
      col = img.get((int)pos.y, (int)pos.x);
    }
    fill(col);
    if(dynamicOpacity)fill(col, map(rad, minRad, maxRad, 10, 205));
    circle(pos.x, pos.y, rad);
  }
  
  void reset()
  {
    rad = initRad;
    pos = new PVector(random(0, width), random(0, height));
    rate = random(radRedRate/2, radRedRate);
  }
  
}
