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
    radius = 40;
    col = color(50, 120, 200);
    opacity = 0;
    mDir = random(-1, 1) > 0 ? 1 : -1;
  }
  
  public void update() {
    radius = radius - 0.5;
    opacity = opacity + 5;
  }
  
  public void draw(Season season, PGraphics pg) {
    pg.noStroke();
    
    switch (season) {
      case SPRING:
        pg.fill(255, 100, 210, opacity);
        break;
        
      case SUMMER:
        pg.fill(255, 255, 0, opacity);
        break;
        
      case AUTUMN:
        pg.fill(255, 100, 0, opacity);
        break;
        
      case WINTER:
        pg.fill(col, opacity);
        break;
    }
    pg.ellipse(x + sin(frameCount * 0.1) * random(6, 7) * mDir, y, radius, radius);
  }
  
  public boolean shouldRemove() {
    return radius < 0;
  }
}