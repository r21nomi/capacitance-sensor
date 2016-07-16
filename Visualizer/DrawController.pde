class DrawController {

  private ArrayList<Particle> ballList = new ArrayList();

  public DrawController() {
    // no-op
  }

  public void addParticle(Particle particle) {
    ballList.add(particle);
  }

  public void draw(Season season, PGraphics pg) {
     switch (season) {
       case SPRING:
         pg.fill(0, 255);
         break;

       case SUMMER:
         pg.fill(0, 255);
         break;

       case AUTUMN:
         pg.fill(255, 255);
         break;

       case WINTER:
         pg.fill(0, 255);
         break;
     }
    pg.rect(0, 0, width, height);

    Iterator iterator = ballList.iterator();
    while(iterator.hasNext()) {
      Particle particle = (Particle)iterator.next();

      particle.draw(season, pg);

      if (particle.shouldRemove()) {
        iterator.remove();

      } else {
        particle.update();
      }
    }
  }
}
