public class ScreenManager {
    private final GuiManager guiManager;

    private int currentScreen = null;

    public ScreenManager(GuiManager guiManager) {
        this.guiManager = guiManager;
    }

    public void draw() {
        guiManager.draw();
    }

    public boolean createScreen(int id) {
        return guiManager.createScreen(id);
    }

    public boolean setScreen(int id) {
        if (guiManager.setScreen(id)) {
            currentScreen = id;
            return true;
        }

        return false;
    }

    public int getCurrentScreen() {
        return currentScreen;
    }
}