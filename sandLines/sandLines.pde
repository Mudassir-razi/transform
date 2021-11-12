int maxPoints = 12;
float ringRad = 100;
Bez curve;

boolean done;
PGraphics pg;

//color
color backDrop = #111e29;


void setup()
{
  size(800, 800);
  pg = createGraphics(800, 800);
  curve = new Bez();
  for (int i = 0; i < maxPoints-1; i++)
  {
    PVector pos = new PVector(width/2, height/2);
    float angle = (2 * PI)/maxPoints;
    pos.add(ringRad * cos(i * angle), ringRad * sin(i * angle));
    curve.points.add(pos);
  }
  curve.points.add(curve.points.get(0));
  curve.reset();
  background(backDrop);
}

void draw()
{
  //background(backDrop);
  //image(pg, 0, 0);
  //blendMode(NORMAL);
  //fill(backDrop, 10);
  //square(0, 0, width);
  curve.drawCurve();
  curve.randomize();
  curve.reset();
}
