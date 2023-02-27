public class GuiManager {
    private final Map<Integer, ArrayList<Button>> screens = new HashMap<Integer, ArrayList<Button>>();

    private boolean enabled = true;
    private boolean currentScreen = null;

    public GuiManager() {}

    public void click(float x, float y) {
        if (!enabled) {
            return;
        }
    }

    public boolean createScreen(int id) {
        if (screens.hasKey(id)) {
            return false;
        }

        screens.put(id, new ArrayList<Button>());
        return true;
    }

    public boolean registerButton(Button button, int screen) {
        if (!screens.hasKey(screen)) {
            return false;
        }

        screens.get(screen).add(button);
        return true;
    }

    public void enable() {
        enabled = true;
    }

    public void disable() {
        enabled = false;
    }

    public void toggle() {
        if (!enabled) {
            enable();
        } else {
            disable();
        }
    }

    public boolean isEnabled() {
        return enabled;
    }

    public int getCurrentScreen() {
        return currentScreen;
    }
}