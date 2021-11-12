ArrayList<particle> particles;
int maxParticle = 120;

void setup()
{
  size(800, 800);
  background(0);
  particles = new ArrayList<particle>();
  initGrid();

  for (int i = 0; i < maxParticle; i++)
  {
    PVector tempP = new PVector(random(0, width), random(0, height));
    PVector tempV = new PVector(random(-1, 1), random(-1, 1)).normalize();
    particles.add(new particle(tempP, tempV));
  }
}

void draw()
{
  //draw horizontal lines
  //background(0);
  fill(0, 5);
  square(0, 0, width);
  for (int i = 0; i < maxParticle; i++)
  {
    particles.get(i).updatePosition();
    particles.get(i).updateGrid();
    particles.get(i).checkCollision();
  }
}
