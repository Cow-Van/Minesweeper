public abstract class Button {
    protected final float x;
    protected final float y;
    protected final float wid;
    protected final float hei;
    protected final int buttonShape;

    protected color col;

    public Button(float x, float y, float wid, float hei, color col, int buttonShape) {
        this.x = x;
        this.y = y;
        this.wid = wid;
        this.hei = hei;
        this.col = col;
        this.buttonShape = buttonShape;
    }

    public abstract void leftClick();

    public abstract void rightClick();

    public void draw() {
        fill(col);
        if (buttonShape == ButtonShape.RECTANGLE) {
            rect(x, y, wid, hei);
        } else if (buttonShape == ButtonShape.ELLIPSE) {
            ellipse(x, y, wid, hei);
        }
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public float getWidth() {
        return wid;
    }

    public float getHeight() {
        return hei;
    }

    public int getButtonShape() {
        return buttonShape;
    }
}
