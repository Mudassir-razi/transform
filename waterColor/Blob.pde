class Blob
{
  //properties
  PVector center;
  ArrayList<PVector>points;
  int maxPoints = 155;
  int radius = 80;
  int layer = 50;
  float offset = 0.51;
  float angleRnd = PI/6;
  float splitProb = 0.1;

  //rendering
  float initOpacity = 120;
  float opacityRedRate = 20;
  color fillC = #2877A0;
  boolean stroke = false;
  boolean rndColor = true;

  //stats
  int l;
  float opacity;

  Blob(PVector p, int r)
  {
    center = p;
    radius = r;
    l = 0;
    opacity = initOpacity;
  }

  Blob(PVector p)
  {
    center = p;
    l = 0;
    opacity = initOpacity;
  }

  //initialize()
  void init()
  {
    points = new ArrayList<PVector>();
    for (int i = 0; i < maxPoints; i++)
    {
      float angle = (2 * PI)/maxPoints;
      PVector temp = new PVector(center.x, center.y);
      temp.add(cos(angle * i) * radius, sin(angle * i) * radius);
      points.add(temp);
    }
    if (rndColor)fillC = color(random(0, 255), random(0, 255), random(0, 255));
  }

  //render blob
  boolean render()
  {
    stroke(0, 80);
    if (!stroke)noStroke();
    fill(fillC, map(l, 0, layer, initOpacity, 0));
    opacity -= opacityRedRate;
    beginShape();
    for (int i = 0; i < points.size(); i++)
    {
      vertex(points.get(i).x, points.get(i).y);
    }
    vertex(points.get(0).x, points.get(0).y);
    endShape(CLOSE);
    l++;
    return true;
  }

  void displace()
  {
    if (l > 0)return;
    float angle = (2 * PI)/points.size();
    for (int j = 0; j < octaves; j++)
    {
      for (int i = 0; i < points.size(); i++)
      {
        float val = 0;
        PVector p = new PVector(points.get(i).x, points.get(i).y);
        val += (noise(p.x * pow(lacunarity, j) * baseFreq, p.y * pow(lacunarity, j) * baseFreq) * 2 - 1) * pow(persistance, j);
        val *= amplitude;
        p.add(val * cos(angle * i), val * sin(angle * i));
        points.set(i, p);
      }
      render();
    }
  }

  //subdivides the polygon
  void tessalate()
  {
    if (l >= layer)return;
    l++;
    ArrayList nPoints = new ArrayList<PVector>();
    float prob;

    for (int i = 0; i < points.size()-1; i++)
    {
      PVector vA = new PVector(points.get(i).x, points.get(i).y);
      PVector vB = new PVector(points.get(i+1).x, points.get(i+1).y);
      PVector dir = new PVector(vB.x - vA.x, vB.y - vA.y);
      PVector newPos = new PVector((vA.x + vB.x)/2, (vA.y + vB.y)/2);

      nPoints.add(vA);
      prob = random(0, 1);
      if (prob > splitProb)continue;
      dir.rotate(-PI/2);
      dir.rotate(random(-angleRnd, angleRnd));
      newPos.add(dir.mult(offset));
      //circle(newPos.x, newPos.y, 4);
      nPoints.add(newPos);
    }

    //calculating last point manually
    PVector vA = points.get(points.size()-1);
    PVector vB = points.get(0);
    PVector dir = new PVector(vB.x - vA.x, vB.y - vA.y);
    PVector newPos = new PVector((vA.x + vB.x)/2, (vA.y + vB.y)/2);
    nPoints.add(vA);

    prob = random(0, 1);
    if (prob <= splitProb) {
      dir.rotate(-PI/2);
      dir.rotate(random(-angleRnd, angleRnd));
      newPos.add(dir.mult(random(offset/2, offset)));
      //circle(newPos.x, newPos.y, 4);
      nPoints.add(newPos);
    }
    //assign new points to points
    points = nPoints;
  }
}
