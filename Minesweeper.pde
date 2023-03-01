final GuiManager guiManager = new GuiManager();
final ScreenManager screenManager = new ScreenManager(guiManager);

public void setup() {
    rectMode(CENTER);
    size(750, 750);
    screenManager.createScreen(0);
    screenManager.createScreen(1);
    screenManager.setScreen(0);
}

public void draw() {
    background(255);

    screenManager.draw();
}

public void mouseClicked() {
    if (mouseButton == LEFT) {
        guiManager.leftClick(mouseX, mouseY);
    } else if (mouseButton == RIGHT) {
        guiManager.leftClick(mouseX, mouseY);
    }
}