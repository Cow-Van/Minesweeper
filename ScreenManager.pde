public class ScreenManager {
    private final GuiManager guiManager;

    public ScreenManager(GuiManager guiManager) {
        this.guiManager = guiManager;
    }

    public void draw() {
        guiManager.draw();
    }
}