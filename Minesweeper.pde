public final GuiManager guiManager = new GuiManager();

public void setup() {
    size(750, 750);
}

public void draw() {
    background(255);
}

public void mouseClicked() {
    guiManager.click(mouseX, mouseY);
}