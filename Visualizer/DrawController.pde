class DrawController {
  
  private ArrayList<Particle> ballList = new ArrayList();
  
  public DrawController() {
    // no-op
  }
  
  public void addParticle(Particle particle) {
    ballList.add(particle);
  }
  
  public void draw() {
    fill(255, 100);
    noStroke();
    
    Iterator iterator = ballList.iterator();
    while(iterator.hasNext()) {
      Particle particle = (Particle)iterator.next();
      
      particle.draw();

      if (particle.shouldRemove()) {
        iterator.remove();
        
      } else {
        particle.update();
      }
    }
  }
}