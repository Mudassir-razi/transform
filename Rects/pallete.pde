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
