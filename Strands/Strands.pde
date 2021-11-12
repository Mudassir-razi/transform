ArrayList<PVector>points;
int maxPoints = 6;
int circlePoint = 5;
float freq = 0.001;
float step = 2;
void setup()
{
  size(800, 800);
  points = new ArrayList<PVector>();
  for (int i = 0; i < maxPoints; i++)
  {
    PVector p = new PVector(random(0, width/2), random(height/2));
    points.add(p);
  }
}

void draw()
{
  background(0);
  stroke(255, 150);
  noFill();
  float angle = (2 * PI)/circlePoint;
  for (int j = 0; j < circlePoint; j++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(j * angle);
    circle(points.get(maxPoints-2).x, points.get(maxPoints-2).y, 4);
    beginShape();
    for (int i = 0; i < maxPoints; i++)
    {
      PVector p = new PVector(points.get(i).x, points.get(i).y);
      curveVertex(p.x, p.y);
    }
    endShape();
    popMatrix();
    PVector p = new PVector(points.get(maxPoints - 2).x, points.get(maxPoints - 2).y);
    float dX = noise(p.x * freq) * 2 - 1;
    float dY = noise(p.y * freq) * 2 - 1;
    p.add(dX * step, dY * step);
    points.set(maxPoints - 2, p);
  }
}
