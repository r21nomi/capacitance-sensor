class Particle {
  
  private float x;
  private float y;
  private float radius;
  private float col;
  private float opacity;
  
  public Particle(float voltageMax, float timeMax, float minVoltage, float maxVoltage, float boundary) {
    float velocity = map(timeMax, 120, 140, 1, 1.5);
    x = random(1, width);
    y = random(1, height);
    radius = map(voltageMax, minVoltage, maxVoltage, 10, 2) * velocity;
    col = map(voltageMax, boundary, maxVoltage, 0, 255);
    opacity = 255;
  }
  
  public void update() {
    radius = radius + 10;
    opacity = opacity - 10;
  }
  
  public void draw(PGraphics pg) {
    pg.noStroke();
    pg.fill(col, 10, col, opacity);
    pg.ellipse(x, y, radius, radius);
  }
  
  public boolean shouldRemove() {
    return opacity < 0;
  }
}