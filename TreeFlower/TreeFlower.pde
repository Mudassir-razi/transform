ArrayList<Node> points;

void setup()
{
  ///fullScreen();
  size(800, 800);
  points = new ArrayList<Node>();

  //noLoop();
  stroke(0);
  background(255);
  createPalette();
}

void draw()
{
  //background(255);
  stroke(0);
  place();
  for (int i = 0; i < points.size(); i++)
  {
    points.get(i).render();
  }
  //println(points.size());
}

void place()
{
  //println("New loop");
  PVector p = new PVector(random(width), random(height));
  int newLevel = (int)random(5, 8);
  float newOff = random(5, 30);
  
  boolean canPlace = true;
  for (int i = 0; i < points.size(); i++)
  {
    PVector n = new PVector(points.get(i).pos.x, points.get(i).pos.y);
    PVector disV = new PVector(p.x - n.x, p.y - n.y);
    float dis = disV.mag();
    float rad = newOff * (newLevel + 3) * 0.5;
    float disBetweenCenter = rad + points.get(i).rad;
    
    if(p.x + rad > width || p.x - rad < 0 || p.y + rad > height || p.y - rad < 0)
    {
      canPlace = false;
      break;
    }
    if (disBetweenCenter/2 > dis)
    {
      canPlace = false;
      break;
    }
  }
  
  if (canPlace)
  {
    Node nn = new Node(p.x, p.y, newOff, newLevel);
    points.add(nn);
  }
}
