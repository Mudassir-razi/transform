

class Node
{

  ArrayList<PVector> nodes;
  ArrayList<PVector> dir;
  PVector pos;
  float angleOffset = 0;
  float offset = 80;
  float offsetFactor = 0.5;
  float angleFactor = 1;
  float rad;
  int level = 6;
  int petal = 6;
  boolean finished;
  color c;

  Node(float x, float y, float r, int l)
  {
    pos = new PVector(x, y);
    offset = r;
    level = l;
    c = palette[(int)random(0, paletteSize)];
    petal = (int)random(5, 6);

    //init data
    nodes = new ArrayList<PVector>();
    dir = new ArrayList<PVector>();
    rad = offset * (level+3) * offsetFactor;

    //
    int tNode = (int)pow(2, level);
    for (int i = 0; i < tNode; i++)
    {
      PVector p = new PVector(0, 0);
      PVector p2 = new PVector(1, 0);
      nodes.add(p);
      dir.add(p2);
    }
    finished = false;
  }

  void render()
  {
    //if(finished)return;
    pushMatrix();
    //translate(width/2, height/2);
    translate(pos.x, pos.y);
    rotate(PI/2);
    scale(-1, 1); 
    stroke(c);
    noFill();
    //circle(0, 0, rad);
    rad = offset * (level+3) * offsetFactor;

    //try grow
    boolean canPlace = true;
    for (int i = 0; i < points.size(); i++)
    {
      if(points.get(i) == this)continue;
      PVector n = new PVector(points.get(i).pos.x, points.get(i).pos.y);
      PVector disV = new PVector(pos.x - n.x, pos.y - n.y);
      float dis = disV.mag();
      float disBetweenCenter = rad + points.get(i).rad;
      
      if (disBetweenCenter/2 > dis)
      {
        canPlace = false;
        break;
      }
    }
    if(canPlace)offset += 1;

    //popMatrix();
    for (int i = 0; i < nodes.size(); i++)
    {
      PVector cur = nodes.get(i);
      PVector cDir = dir.get(i);
      PVector del1 = new PVector(cDir.x, cDir.y);
      PVector del2 = new PVector(cDir.x, cDir.y);
      del1.rotate(-angleOffset * angleFactor);
      del2.rotate(angleOffset * angleFactor);
      int c1 = 2 * i + 1;
      int c2 = 2 * i + 2;
      if (c1 >= nodes.size() || c2 >= nodes.size())break;
      PVector p1 = new PVector(cur.x + del1.x * offset, cur.y + del1.y * offset);
      PVector p2 = new PVector(cur.x + del2.x * offset, cur.y + del2.y * offset);
      strokeWeight(map(cDir.mag(), 0, 1, 1, 4));
      nodes.get(c1).set(p1);
      nodes.get(c2).set(p2);
      dir.get(c1).set(del1.mult(offsetFactor));
      dir.get(c2).set(del2.mult(offsetFactor));
      float angle = (2 * PI)/petal;
      for (int j = 0; j < petal; j++)
      {
        pushMatrix();
        rotate(j * angle);
        line(cur.x, cur.y, p1.x, p1.y);
        line(cur.x, cur.y, p2.x, p2.y);
        popMatrix();
      }
    }
    popMatrix();
    if (angleOffset < 0.25)angleOffset += 0.01;
    else finished = true;
    //println(angleOffset);
  }
}
