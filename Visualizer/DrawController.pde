class DrawController {
  
  private ArrayList<Particle> ballList = new ArrayList();
  
  public DrawController() {
    // no-op
  }
  
  public void addParticle(Particle particle) {
    ballList.add(particle);
  }
  
  public void draw(PGraphics pg) {
    Iterator iterator = ballList.iterator();
    while(iterator.hasNext()) {
      Particle particle = (Particle)iterator.next();
      
      particle.draw(pg);

      if (particle.shouldRemove()) {
        iterator.remove();
        
      } else {
        particle.update();
      }
    }
  }
}