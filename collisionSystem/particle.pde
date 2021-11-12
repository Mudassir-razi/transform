//Grid data
ArrayList<ArrayList> grid;
int gridSize = 50;              //grid size must be greater than minimum particle radius
//recommended grid size: a factor of width & height

//simulation parameters
int initRad = 8;
int checkGridRad = 1;
float speed = 1;
float randomizeDirAmount = 0.1;
float reppelForce = 0.4;
float alignForce = 0.2;
boolean loopWorld = true;
boolean randomizeDir = true;
boolean reppel = true;
boolean align = true;
boolean debugMode = false;


//rendering
color lineColor = #999999;
color particle = #22c97b;
float particleRad = 4;
boolean drawParticle = false;
boolean drawLine = true;

class particle
{
  //properties
  PVector pos;
  PVector vel;
  boolean dead;
  float rad;
  float step;
  int gridIndex; 

  particle(PVector p, PVector d)
  {
    pos = p;
    vel = d;
    rad = initRad;
    step = speed;
    gridIndex = -1;
    dead = false;
    updateGrid();
  }

  void updatePosition()
  {
    PVector del = new PVector(vel.x * step, vel.y * step);
    pos.add(del);
    ifDead();

    if (loopWorld)
    {
      if (pos.x > width)pos.set(1, pos.y);
      if (pos.x < 0)pos.set(width-1, pos.y);
      if (pos.y > height)pos.set(pos.x, 1);
      if (pos.y < 0)pos.set(pos.x, height-1);
    }

    if (randomizeDir)
    {
      PVector rnd = new PVector(random(-1, 1) * randomizeDirAmount, random(-1, 1) * randomizeDirAmount);
      vel.add(rnd).normalize();
    }
  }

  void ifDead()
  {
    if(loopWorld)return;
    if (pos.x > width || pos.x < 0)dead = true;
    if (pos.y > height || pos.y < 0)dead = true;
  }

  void updateGrid()
  {
    int gX = floor(pos.x/gridSize);
    int gY = floor(pos.y/gridSize);
    int gI = gY * (width/gridSize) + gX;

    //means it's out of the boundary
    if (gI >= grid.size())return;
    if (gX > width || gX < 0)return;
    if (gY > height || gY < 0)return;

    //for the first time, we don't remove anything
    if (gridIndex != -1)grid.get(gridIndex).remove(this);
    grid.get(gI).add(this);
    gridIndex = gI;

    //for debugging
    if (debugMode) {
      println(pos);
      println(gX, gY, gridIndex);
    }

    //drawing particles
    if (drawParticle) {
      fill(particle);
      noStroke();
      circle(pos.x, pos.y, particleRad);
    }
  }

  boolean checkCollision()
  {
    boolean collides = false;
    int gX = floor(pos.x/gridSize);
    int gY = floor(pos.y/gridSize);
    for (int i = gX - checkGridRad; i <= gX + checkGridRad; i++)
    {
      if (i < 0 || i > (width/gridSize-1))continue;

      for (int j = gY - checkGridRad; j <= gY + checkGridRad; j++)
      {
        int gI = j * (width/gridSize) + i;

        //if out of the grid, no need to check
        if (gI >= grid.size() || gI < 0)continue;
        if (j < 0 || j > (height/gridSize - 1))continue;

        ArrayList<particle> cell = grid.get(gI);
        for (int k  = 0; k < cell.size(); k++)
        {
          //if it's just me, no collision
          particle tempP = cell.get(k);
          if (tempP == this)continue;
          if (tempP.dead)continue;
          PVector dist = new PVector(pos.x - tempP.pos.x, pos.y - tempP.pos.y);
          float cen2cen = rad + tempP.rad;
          float distF = dist.mag();

          //drawing trail
          if (drawLine) {
            stroke(lineColor);
            line(pos.x, pos.y, tempP.pos.x, tempP.pos.y);
          }
          //if rad1 + rad2 <= center distance, it's a collision
          if (cen2cen >= distF)
          {
            collides = true;
            return collides;
          }

          //if collision has not happened, we affect the velocity
          if (align) {
            float aff = 1/distF;
            vel.add(new PVector(tempP.vel.x * aff * alignForce, tempP.vel.y * aff * alignForce));
            vel.normalize();
          }
          
          //reppel
          if(reppel)
          {
            float rf = 1/distF;
            rf = rf * rf;
            PVector rfv = new PVector(dist.x, dist.y);
            rfv.mult(rf * reppelForce);
            vel.add(rfv).normalize();
          }
        }
      }
    }
    return collides;
  }
}

//initialize the grid that holds particles
void initGrid()
{
  grid = new ArrayList<ArrayList>();
  int w = width/gridSize;
  int h = height/gridSize;
  for (int i = 0; i < h * w; i++)
  {
    grid.add(new ArrayList<particle>());
  }
}
