public enum ItemType {
    PARTICLE(1, 0),
    CIRCLE(2, 100);
    
    int id;
    int delay;
    
    ItemType(int id, int delay) {
      this.id = id;
      this.delay = delay;
    }
}