class Particle {
  
  private float x;
  private float y;
  private float radius;
  private color col;
  private float opacity;
  private float mDir;
  
  public Particle(float voltageMax, float timeMax, float minVoltage, float maxVoltage, float boundary) {
    float velocity = map(timeMax, 120, 140, 1, 1.5);
    float alpha = map(voltageMax, boundary, maxVoltage, 0, 255);
    x = random(1, width);
    y = random(1, height);
    //radius = map(voltageMax, minVoltage, maxVoltage, 20, 30) * velocity;
    radius = 60;
    col = color(50, 120, 200);
    opacity = 0;
    mDir = random(-1, 1) > 0 ? 1 : -1;
  }
  
  public void update() {
    radius = radius - 1;
    opacity = opacity + 5;
  }
  
  public void draw(PGraphics pg) {
    pg.noStroke();
    pg.fill(col, opacity);
    pg.ellipse(x + sin(frameCount * 0.1) * random(6, 8) * mDir, y, radius, radius);
  }
  
  public boolean shouldRemove() {
    return radius < 0;
  }
}