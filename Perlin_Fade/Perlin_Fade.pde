ArrayList<Particle> points;
PImage img;
boolean start = false;

int maxPoint = 3000;
float step = 4;
float initRad = 0.1;
float radRedRate = -0.15;
float minRad = 0.1;
float maxRad = 8;

//noise parameters
float scale = 0.002;
float offsetX = 0;
float offsetY = 0;
float offsetDel = 0.00;

//color
boolean pic = false;
boolean randomGen = true;
boolean dynamicOpacity = true;
color backDrop = #121417;
color trail = #328dc2;
color particle = #ff004c;

void setup()
{
  //size(1920, 1080);
  fullScreen();
  background(0);
  points = new ArrayList<Particle>();
  img = loadImage("boats.png");

  for (int i = 0; i < maxPoint; i++)
  {
    Particle p = new Particle(new PVector(random(0, width), random(0, height)), trail, initRad);
    points.add(p);
    p.setColorFromPic();
  }
  
  noStroke();
  noiseSeed(24);
}

void draw()
{
  if (!start)return;
  //draw square
  //blendMode(SUBTRACT);
  //fill(0, 2);
  //rect(0, 0, width, height);
  //blendMode(NORMAL);
  
  for(int i = 0;i < maxPoint;i++)
  {
    Particle pc = points.get(i);
    pc.update();
    pc.render();
  }
}

void keyPressed()
{
  start = true;
  reset();
}

void reset()
{
  noiseSeed((int)random(0, 100));
  background(backDrop);
  for (int i = 0; i < maxPoint; i++)
  {
    Particle p = points.get(i);
    p.reset();
  }
}
