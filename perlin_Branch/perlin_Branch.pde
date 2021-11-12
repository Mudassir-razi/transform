agent a;
ArrayList<agent> agents;
int maxAgent = 10;

void setup()
{
  size(800, 800);
  background(0);
  agents = new ArrayList<agent>();
  noiseSeed(0);
  for(int i = 0;i < maxAgent;i++)
  {
    PVector p = new PVector(random(0, width), random(0, height));
    PVector d = new PVector(random(-1,1), random(-1,1)).normalize();
    agents.add(new agent(p, d));
  }
}

void draw()
{
  for(int i = 0;i < agents.size();i++)
  {
    agents.get(i).update();
  }
}
