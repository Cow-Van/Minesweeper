public class ScreenManager {
    private final GuiManager guiManager;
    private final HashMap<Integer, GameManager> gameManagers = new HashMap<Integer, GameManager>();

    private int currentScreen = null;

    public ScreenManager(GuiManager guiManager) {
        this.guiManager = guiManager;
    }

    public void draw() {
        if (currentScreen != null && gameManagers.get(currentScreen) != null) {
            gameManagers.get(currentScreen).draw();
        }

        guiManager.draw();
    }

    public void registerGameManager(int id, GameManager gameManager) {
        gameManagers.put(id, gameManager);
    }

    public boolean createScreen(int id) {
        if (!guiManager.createScreen(id) || gameManagers.containsKey(id)) {
            return false;
        }

        gameManagers.put(id, null);

        return true;
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
