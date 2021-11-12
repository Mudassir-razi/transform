int paletteSize = 5;
int i, j;
int si, sj;
float size = 20;
float shadowDis = 8;
float shadowWidthMult = 2;
PVector light;
boolean done;
boolean useImage = true;
boolean circles = false;
boolean backDrop = true;
boolean shadow = true;
boolean shade = true;
PImage img;

void setup()
{
  fullScreen();
  //size(800, 800);
  img = loadImage("buet1.png");
  si = 0;
  sj = 0;
  if (useImage)checkNonZero();
  light = new PVector(1, 0).normalize();
  reset();
  println(si, sj);
}

void draw()
{
  //image(img, 0, 0);
  if (!done) {

    drawDeep(new PVector(i, j));

    i += size;
    if (i >= width)
    {
      i = 0;
      j += size;
      if (j % height == 0)
      {
        done = true;
      }
    }
  }
}

void keyPressed()
{
  if (key == 'r')reset();
  if (key == 's')saveFrame("line-######.png");
}

void reset()
{
  background(40);
  done = false;
  i = si;
  j = sj;
  createPalette();
}


void checkNonZero()
{
  for (int x = 0; x < width; x += size)
  {
    for (int y = 0; y < height; y += size)
    {
      float mapx = map(x, 0, width, 0, img.width);
      float mapy = map(y, 0, height, 0, img.height);
      float mapV = red(img.get((int)mapx, (int)mapy));
      if (mapV < 100)
      {
        si = x;
        sj = y;
        return;
      }
    }
  }
}

void drawDeep(PVector pos)
{
  float s = (sqrt(2) * size);
  float val = random(1);
  float sw = random(1, 0.4 * s);
  float len;
  PVector p1 = new PVector(0, 0);
  PVector p2 = new PVector(0, 0);
  float mapx = map(pos.x, 0, width, 0, img.width);
  float mapy = map(pos.y, 0, height, 0, img.height);
  float mapV = red(img.get((int)mapx, (int)mapy));
  if (mapV > 100 && useImage)return;

  if (val < 0.5)
  {
    p1.set(pos.x, pos.y);
    p2.set(pos.x + s * cos(PI/4), pos.y + s * sin(PI/4));
  } else if (val <= 1)
  {
    p1.set(pos.x + s * cos(PI/4), pos.y);
    p2.set(pos.x, pos.y + s * sin(PI/4));
  }

  if (backDrop)
  {
    noStroke();
    fill(0, 40);
    rect(pos.x, pos.y, size, size);
  }

  if (shadow) {
    pushMatrix();
    strokeWeight(sw * shadowWidthMult);
    translate(light.x * shadowDis, light.y * shadowDis);
    stroke(0, 70);
    line(p1.x, p1.y, p2.x, p2.y);
    popMatrix();
  }
  len = dist(p1.x, p1.y, p2.x, p2.y);
  strokeWeight(sw);
  stroke(palette[(int)random(paletteSize)]);
  line(p1.x, p1.y, p2.x, p2.y);
  fill(palette[(int)random(paletteSize)]);

  if (shade)
  {
    float factor = 0.4;
    blendMode(MULTIPLY);
    pushMatrix();
    strokeWeight(sw * 0.5);
    translate(light.x * shadowDis * factor, light.y * shadowDis * factor);
    stroke(0, 70);
    line(p1.x, p1.y, p2.x, p2.y);
    popMatrix();
    blendMode(NORMAL);
  }

  if (circles) {
    circle(p1.x, p1.y, random(1, len/3));
    circle(p2.x, p2.y, random(1, len/3));
  }
}

color palette[] = new color[5];
void createPalette() {
  int hue = round(random(360));
  int r1  = round(random(180));
  palette[0] = color(hue - (r1*2), round(random(100)), round(random(100)));
  palette[1] = color(hue - r1, round(random(100)), round(random(100)));
  palette[2] = color(hue, round(random(100)), round(random(100)));
  palette[3] = color(hue + r1, round(random(100)), round(random(100)));
  palette[4] = color(hue + (r1*2), round(random(100)), round(random(100)));
}
