int maxPoints = 5;
int step = 2;
float scale = 10;
float shiftAmount = 0.1;
ArrayList<PVector> points;
ArrayList<PVector> polynomial;
ArrayList<PVector> diffp;
ArrayList<PVector>dir;

pallete col;
boolean done;
void setup()
{
  size(800, 800);
  initialize();
  col = new pallete();
  col.c1 = #57E9E3;
  col.c2 = #194353;
  //println(diff(points));
  done = false;
  colorMode(HSB, 255);
}

void draw()
{
  background(250);
  //translate(width/2, height/2);
  for (int x = 0; x < width; x += 4)
  {
    for (int y = 0; y < height; y += 4)
    {

      //iterate through root finding method
      //aka newton-raphson method
      PVector pos = new PVector(map(x, 0, width, -scale/2, scale/2), map(y, 0, height, -scale/2, scale/2));
      for (int count = 1; count < step; count++)
      {
        PVector nom = eval(polynomial, pos);
        PVector denom = inverse(eval(diffp, pos));
        pos.sub(mult(nom, denom));
      }

      float minDis = 100000000;
      int nearest = 0;
      for (int i = 0; i < maxPoints; i++)
      {
        PVector temp = new PVector(pos.x, pos.y);
        //stroke(0);
        //circle(x, y, 4);
        float dis = PVector.dist(temp, points.get(i));
        if (dis < minDis)
        {
          minDis = dis;
          nearest = i;
        }
      }
      //println(nearest);
      //circle(x, y, 10 * nearest);
      int cVal = (int)map(nearest, 0, maxPoints, 50, 235);
      color c = color(cVal, cVal, cVal);
      fill(col.getCol(0, maxPoints, nearest));
      noStroke();
      //println(minDis);
      circle(x, y, 6);
      //set(x, y, );
    }
  }
  shift();
}

void keyPressed()
{
  done = false;
  initialize();
  background(0);
}

void shift()
{
  //shifting points a bit
  for (int i = 0; i < maxPoints; i++)
  {
    PVector pos = new PVector(points.get(i).x, points.get(i).y);
    PVector dirv = new PVector(dir.get(i).x, dir.get(i).y);
    pos.add(dirv.mult(shiftAmount));
    points.set(i, pos);
  }
  polynomial.clear();
  polynomial.add(new PVector(1, 0));
  polynomial.add(negate(points.get(0)));
  for (int i = 1; i < maxPoints; i++)
  {
    polynomial = conv(polynomial, negate(points.get(i)));
  }
  diffp = diff(polynomial);
}

void initialize()
{
  points = new ArrayList<PVector>();
  polynomial = new ArrayList<PVector>();
  dir = new ArrayList<PVector>();
  
  for(int i = 0;i < maxPoints;i++)
  {
    PVector rnd = new PVector(random(-1, 1), random(-1, 1)).normalize();
    dir.add(rnd);
  }
  
  for (int i = 0; i < maxPoints; i++)
  {
    points.add(new PVector(random(-scale/2, scale/2), random(-scale/2, scale/2)));
  }

  //manually creating first entry of the polynomial
  polynomial.add(new PVector(1, 0));
  polynomial.add(negate(points.get(0)));
  for (int i = 1; i < maxPoints; i++)
  {
    polynomial = conv(polynomial, negate(points.get(i)));
  }
  diffp = diff(polynomial);
}

PVector mult(PVector a, PVector b)
{
  float x = a.x * b.x - a.y * b.y;
  float y = a.x * b.y + a.y * b.x;
  return new PVector(x, y);
}

ArrayList conv(ArrayList poly, PVector a)
{
  int len = poly.size();
  PVector sm[] = {new PVector(1, 0), new PVector(0, 0)};
  sm[1] = a;
  ArrayList<PVector> res = new ArrayList();
  for (int i = 0; i < len+1; i++)
  {
    res.add(new PVector(0, 0));
    for (int j = 0; j <= i; j++)
    {
      int k = i - j;
      if (j >= len || k > 1)continue;
      res.set(i, res.get(i).add(mult((PVector)poly.get(j), sm[k])));
    }
  }

  return res;
}

ArrayList diff(ArrayList poly)
{
  int len = poly.size() - 1;
  ArrayList res = new ArrayList();
  for (int i = len; i >= 0; i--)
  {
    res.add(new PVector(i * ((PVector)poly.get(len - i)).x, i * ((PVector)(poly.get(len - i))).y));
  }
  res.remove(res.size()-1);
  return res;
}

PVector pow(PVector p, int x)
{
  PVector pn = new PVector(1, 0);
  for (int i = 0; i < x; i++)
  {
    pn = mult(pn, p);
  }
  return pn;
}

PVector negate(PVector p)
{
  return new PVector(-p.x, -p.y);
}

PVector inverse(PVector p)
{
  float mod = p.mag();
  return new PVector(p.x/mod, -p.y/mod);
}

PVector eval(ArrayList poly, PVector p)
{
  int degree = poly.size();
  PVector res = new PVector(0, 0);
  for (int i = 0; i < degree; i++)
  {
    res.add(mult(pow(p, degree - i), (PVector)poly.get(i)));
  }
  return res;
}
