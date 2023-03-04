private final GuiManager guiManager = new GuiManager();
private final GameManager gameManager = new GameManager(guiManager);
private final ScreenManager screenManager = new ScreenManager(guiManager);

public void setup() {
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    size(750, 750);
    screenManager.createScreen(0);
    screenManager.setScreen(0);
    screenManager.registerGameManager(0, gameManager);
    gameManager.setBoardSize(20, 20);
    gameManager.reset();
}

public void draw() {
    background(255);

    stroke(0, 255, 0);
    screenManager.draw();
}

public void mouseClicked() {
    if (mouseButton == LEFT) {
        guiManager.leftClick(mouseX, mouseY);
    } else if (mouseButton == RIGHT) {
        guiManager.rightClick(mouseX, mouseY);
    }
}

public void keyPressed() {
    if (key == 'r') {
        gameManager.reset();
    }
}