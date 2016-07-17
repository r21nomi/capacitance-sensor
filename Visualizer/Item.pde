interface Item {
    void update(float velocity);
    void draw(PGraphics pg);
    boolean shouldRemove();
}