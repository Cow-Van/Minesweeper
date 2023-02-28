public final GuiManager guiManager = new GuiManager();
Button b1 = new Button(375, 375, 500, 400, color(255, 0, 0), ButtonShape.ELLIPSE);

public void setup() {
    rectMode(CENTER);
    size(750, 750);
    guiManager.createScreen(0);
    guiManager.setScreen(0);
    guiManager.registerButton(0, b1);
}

public void draw() {
    background(255);

    guiManager.draw();
}

public void mouseClicked() {
    guiManager.click(mouseX, mouseY);
}