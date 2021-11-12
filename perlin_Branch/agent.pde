float step = 0.5;
float rad = 1;
float noiseScale = 0.01;
float noiseStep = 3;

class agent
{
  PVector dir;
  PVector pos;
  boolean dead;

  agent(PVector p, PVector d)
  {
    pos = p;
    dir = d;
    dead = false;
  }

  void update()
  {
    if(dead)return;
    
    PVector force = new PVector(0, 0);
    for(int i = 0;i < agents.size();i++)
    {
      if(agents.get(i) == this)continue;
      PVector dis = new PVector(
    }
    //print pos
    PVector delP = new PVector(dir.x * step, dir.y * step);
    pos.add(delP);
    stroke(244);
    circle(pos.x, pos.y, rad);

    //update direction
    float delX = noise(pos.x * noiseScale, 10 * noiseStep) * 2 - 1;
    float delY = noise(10 * noiseStep, pos.y * noiseScale) * 2 - 1;
    dir.add(new PVector(delX * noiseStep, delY * noiseStep)).normalize();
  }
  
}
