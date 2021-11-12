ArrayList<Blob> blobs;
int maxBlob = 1;
int octaves = 5;
float lacunarity = 5;
float persistance = 0.3;
float amplitude = 60;
float baseFreq = 0.01;

float freq  = 0.001;
int index;
Math m;
void setup()
{
  size(800, 800);
  background(255);
  m = new Math();
  blobs = new ArrayList<Blob>();
  for (int i = 0; i < maxBlob; i++)
  {
    Blob b = new Blob(new PVector(width/2, height/2), (int)random(50, 100));
    b.init();
    blobs.add(b);
  }
  index = 0;
  noLoop();
}

void draw()
{
  for(int i = 0;i < blobs.size();i++)
  {
    Blob b = blobs.get(i);
    b.displace();
  }
}
