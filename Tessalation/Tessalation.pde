ArrayList<PVector>points;
ArrayList<PVector>centerPoly;

int maxPoints = 6;
float radius = 140;
int layer = 20;
boolean start = false;

int l = 0;
//radomness
//offset good = 0.86
float offset = 0.00;
float angleDiv = 2;
int opacity = 200;
float weight = 4;
color c = #02283B;

void setup()
{
  size(800, 800);
  background(255);
  reset();
}

void draw()
{
  if(!start)return;
  translate(width/2, height/2);
  background(255);
  while (weight >= 0) {
    //noFill();
    stroke(c, opacity);
    strokeWeight(weight);
    noFill();
    //fill(c, map(l, 0, layer, 70, 0)*(4-weight)/2);
    beginShape();
    for (int i = 0; i < points.size(); i++)
    {
      vertex(points.get(i).x, points.get(i).y);
    }
    vertex(points.get(0).x, points.get(0).y);
    endShape();
    opacity -= 25;
    weight -= 0.4;
    reshape();
  }
  //drawCenter();
  radius -= 0.2;
  weight = 4;
  opacity = 255;
  l = 0;
  offset += 0.002;
  if (offset >= 0.86)noLoop();
  reset();
}

void keyPressed()
{
  start = true;
}

void reset()
{
  points = new ArrayList<PVector>();
  centerPoly = new ArrayList<PVector>();
  for (int i = 0; i < maxPoints; i++)
  {
    float angle = (2 * PI)/maxPoints;
    PVector temp = new PVector(0, 0);
    temp.add(cos(angle * i) * radius, sin(angle * i) * radius);
    points.add(temp);
    centerPoly.add(temp);
  }
}

void drawCenter()
{
  fill(255);
  noStroke();
  beginShape();
  for (int i = 0; i < maxPoints; i++)
  {
    vertex(centerPoly.get(i).x, centerPoly.get(i).y);
  }
  vertex(centerPoly.get(0).x, centerPoly.get(0).y);
  endShape();
  noFill();
}

void reshape()
{
  if (l >= layer)return;
  l++;
  ArrayList nPoints = new ArrayList<PVector>();
  for (int i = 0; i < points.size()-1; i++)
  {
    PVector vA = new PVector(points.get(i).x, points.get(i).y);
    PVector vB = new PVector(points.get(i+1).x, points.get(i+1).y);
    PVector dir = new PVector(vB.x - vA.x, vB.y - vA.y);
    PVector newPos = new PVector((vA.x + vB.x)/2, (vA.y + vB.y)/2);

    nPoints.add(vA);
    dir.rotate(-PI/angleDiv);
    newPos.add(dir.mult(offset));
    //circle(newPos.x, newPos.y, 4);
    nPoints.add(newPos);
  }

  //calculating last 2 points manually
  PVector vA = points.get(points.size()-1);
  PVector vB = points.get(0);
  PVector dir = new PVector(vB.x - vA.x, vB.y - vA.y);
  PVector newPos = new PVector((vA.x + vB.x)/2, (vA.y + vB.y)/2);
  nPoints.add(vA);

  dir.rotate(-PI/angleDiv);
  newPos.add(dir.mult(offset));
  //circle(newPos.x, newPos.y, 4);
  nPoints.add(newPos);

  //assign new points to points
  points = nPoints;
}
