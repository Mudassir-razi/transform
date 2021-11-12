PImage img;
float maxRad  = 180;
float radRedRate = 0.1; 
float[] rot = {0, PI/2, PI, 2 * PI};
void setup()
{
  size(360, 760);
  img = loadImage("boats.png");
}

void draw()
{
  PVector pos = new PVector(random(0, width), random(0, height));
  color col = img.get((int)pos.x * 2, (int)pos.y * 2);
  float shape = random(0, 3);
  fill(col);
  noStroke();
  
  if(shape <= 1)circle(pos.x, pos.y, random(2, maxRad));
  if(shape > 1 && shape <= 2)square(pos.x, pos.y, random(2, maxRad));
  if(shape > 2 && shape <= 3)
  {
    int r = (int)random(0, 4);
    translate(random(0, width), random(0, height));
    rotate(rot[r]);
    stroke(col);
    strokeWeight(2);
    line(0, 0, 0, maxRad);
  }
  if(maxRad > 10)maxRad -= radRedRate;
  
}
