public class GuiManager {
    private final Map<Integer, ArrayList<Button>> screens = new HashMap<Integer, ArrayList<Button>>();

    private boolean enabled = true;
    private boolean currentScreen = null;

    public GuiManager() {}

    public void draw() {
        if (!enabled || currentScreen == null) {
            return;
        }

        ArrayList<Button> buttons = screens.get(currentScreen);
        for (int i = 0; i < buttons.size(); i++) {
            buttons.get(i).draw();
        }
    }

    public void click(float x, float y) {
        if (!enabled || currentScreen == null) {
            return;
        }

        ArrayList<Button> buttons = screens.get(currentScreen);
        for (int i = 0; i < buttons.size(); i++) {
            if (isOnButton(buttons.get(i), x, y)) {
                buttons.get(i).click();
            }
        }
    }

    private boolean isOnButton(Button button, float x, float y) {
        switch (button.getButtonShape()) {
            case ButtonShape.RECTANGLE:
                return isInRectangle(x, y, button.getX(), button.getY(), button.getWidth(), button.getHeight());
            case ButtonShape.ELLIPSE:
                return isInEllipse(x, y, button.getX(), button.getY(), button.getWidth() / 2, button.getHeight() / 2);
            default:
                return false;
        }
    }

    private boolean isInRectangle(float x, float y, float centerX, float centerY, float wid, float hei) {
        return x > centerX - (wid / 2) && x < centerX + (wid / 2) && y > centerY - (hei / 2) && y < centerY + (hei / 2);
    }

    private boolean isInEllipse(float x, float y, float h, float k, float rx, float ry) {
        return ((x - h) * (x - h) / (rx * rx)) + ((y - k) * (y - k) / (ry * ry)) <= 1
    }

    public boolean registerButton(int screen, Button button) {
        if (!screens.containsKey(screen)) {
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

    public boolean createScreen(int id) {
        if (screens.containsKey(id)) {
            return false;
        }

        screens.put(id, new ArrayList<Button>());
        return true;
    }

    public boolean setScreen(int id) {
        if (!enabled || !screens.containsKey(id)) {
            return false;
        }

        currentScreen = id;
        return true;
    }

    public int getCurrentScreen() {
        return currentScreen;
    }
}