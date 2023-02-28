public class Button {
    protected final float x;
    protected final float y;
    protected final float wid;
    protected final float hei;
    protected final int buttonShape;

    public Button(float x, float y, float wid, float hei, int buttonShape) {
        this.x = x;
        this.y = y;
        this.wid = wid;
        this.hei = hei;
        this.buttonShape = buttonShape;
    }

    public void draw() {
        if (buttonShape == ButtonShape.RECTANGLE) {
            rect(x, y, wid, hei);
        } else if (buttonShape == ButtonShape.ELLIPSE) {
            ellipse(x, y, wid, hei);
        }
    }

    public void click() {

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
        return height;
    }

    public int getButtonShape() {
        return buttonShape;
    }
}