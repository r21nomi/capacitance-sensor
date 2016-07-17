class Circle implements Item {
    private float mRadius;
    private float mMaxRadius;
    private float mAlpha;
    private color mColor;

    public Circle(color col, float maxRadius) {
        mRadius = 0;
        mMaxRadius = maxRadius;
        mAlpha = 255;
        mColor = col;
    }

    @Override
    public void update(float velocity) {
        mRadius += velocity;
        mAlpha = map(mRadius, 0, mMaxRadius + 100, 255, 0);
    }

    @Override
    public void draw(PGraphics pg) {
        pg.fill(mColor, mAlpha);
        pg.noStroke();
        pg.pushMatrix();
        pg.translate(width / 2, height / 2);
        pg.ellipse(0, 0, mRadius, mRadius);
        pg.popMatrix();
    }

    @Override
    public boolean shouldRemove() {
        return mAlpha < 0;
    }
}