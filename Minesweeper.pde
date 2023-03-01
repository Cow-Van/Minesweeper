final GuiManager guiManager = new GuiManager();
final ScreenManager screenManager = new ScreenManager(guiManager);
Button b1 = new Button(375, 375, 500, 400, color(255, 0, 0), ButtonShape.ELLIPSE);

public void setup() {
    rectMode(CENTER);
    size(750, 750);
    screenManager.createScreen(0);
    screenManager.createScreen(1);
    screenManager.setScreen(0);
    guiManager.registerButton(0, b1);
}

public void draw() {
    background(255);

    screenManager.draw();
}

public void mouseClicked() {
    guiManager.click(mouseX, mouseY);
    screenManager.setScreen(1);
    println(screenManager.getCurrentScreen())
}