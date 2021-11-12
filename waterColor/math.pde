class Math
{
  float gaussDist(float sigma, float x1, float x2)
  {
    float x = random(x1, x2);
    float y = random(x1, x2);
    return sqrt(-2 * log(x)) * sin(2 * PI * y);
  }
}
