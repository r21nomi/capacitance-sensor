class DrawController {

    private ArrayList<Item> ballList = new ArrayList();

    public DrawController() {
    // no-op
    }

    public void addParticle(Item particle) {
        ballList.add(particle);
    }

    public void draw(PGraphics pg) {
        if (mIsDebugMode) {
            pg.fill(255, 255);
        } else {
            pg.fill(0, 255);
        }
        pg.rect(0, 0, width, height);

        Iterator iterator = ballList.iterator();
        while(iterator.hasNext()) {
            Item particle = (Item)iterator.next();

            particle.draw(pg);

            if (particle.shouldRemove()) {
                iterator.remove();

            } else {
                particle.update(10);
            }
        }
    }
}