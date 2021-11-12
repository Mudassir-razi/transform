class Bez
{
  //options
  boolean loop = true;

  ArrayList<PVector>points;
  ArrayList<PVector>bezier;
  float t;

  //color stuff
  color lineColor = #2b3645;
  color circleColor = #6690b0;
  color curveColor = #D6FFA7;
  color backDrop = #111e29;
  boolean drawIntermediate = false;

  //data
  PVector prevPoint;
  boolean stop;

  Bez()
  {
    points = new ArrayList<PVector>();
    bezier = new ArrayList<PVector>();
    t = 0;
    stop = false;
  }

  void reset()
  {
    int len;
    len = (points.size() * (points.size() + 1))/2 - points.size();
    bezier.clear();

    //creatig point list
    for (int i = 0; i < points.size(); i++)
    {
      bezier.add(points.get(i));
    }
    for (int i = 0; i < len; i++)
    {
      bezier.add(new PVector(0, 0));
    }
    prevPoint = points.get(0);
    bezier.set(bezier.size()-1, prevPoint);
  }
  
  void drawCurve()
  {
    for(t = 0;t <= 1;t += 0.005)
    {
      updatePoints();
    }
  }
  
  void updatePoints()
  {
    //cuts the loop
    if (stop)return;

    int n, offset;
    float val;
    val = t;
    n = points.size();
    offset = 0;
    while (n > 1) {
      for (int i = 0; i <= n-2; i++)
      {
        PVector newPoint = interp((PVector)bezier.get(i+offset), (PVector)bezier.get(i+1+offset), val);

        bezier.set(offset + i + n, newPoint);

        if (drawIntermediate) {
          //draws intermediate lines and circles
          strokeWeight(map(n, 0, bezier.size(), 0.5, 2));
          stroke(lineColor);
          fill(circleColor, 40);
          line(bezier.get(i+offset).x, bezier.get(i+offset).y, bezier.get(i+1+offset).x, bezier.get(i+1+offset).y);
          noStroke();
          circle(bezier.get(i+offset).x, bezier.get(i+offset).y, n);
          circle(bezier.get(i+offset+1).x, bezier.get(i+offset+1).y, n);
        }
      }
      offset += n;
      n--;
    }

    //draws head circle
    PVector headPoint = bezier.get(bezier.size()-1);
    //circle(headPoint.x, headPoint.y, 7);
    drawStatGraph();
    //handles loop terminal case
  }

  void randomize()
  {
    int len = points.size();
    float offset = 2;
    float scale = 0.01;
    for (int i = 0; i < len-1; i++)
    {
      PVector pos = new PVector(points.get(i).x, points.get(i).y);
      float dx = noise(pos.x * scale, pos.y * scale) * 2 - 1;
      dx = random(-10, 10);
      float angle = (2 * PI)/maxPoints;
      pos.add( cos(i * angle) * dx * offset, sin(i * angle) * dx * offset);
      curve.points.set(i, pos);
    }
    points.set(len-1, points.get(0));
  }

  void drawStatGraph()
  {
    //draws actual line
    PVector bezPoint;
    //blendMode(SUBTRACT);
    bezPoint = bezier.get(bezier.size() - 1);
    stroke(curveColor, 10);
    line(bezPoint.x, bezPoint.y, prevPoint.x, prevPoint.y);
    prevPoint = bezPoint;
  }

  PVector interp(PVector p1, PVector p2, float val)
  {
    float x = map(val, 0, 1, p1.x, p2.x);
    float y = map(val, 0, 1, p1.y, p2.y);
    return new PVector(x, y);
  }
}
