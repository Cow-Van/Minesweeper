public final GuiManager guiManager = new GuiManager();
Button b1 = new Button(375, 375, 500, 400, ButtonShape.ELLIPSE);

public void setup() {
    rectMode(CENTER);
    size(750, 750);
}

public void draw() {
    background(255);

    if (guiManager.onButton(b1, mouseX, mouseY)) {
        fill(0, 255, 0);
    } else {
        fill(255, 0, 0);
    }

    b1.draw();
}

public void mouseClicked() {
    guiManager.click(mouseX, mouseY);
}