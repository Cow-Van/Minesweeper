public class Tile extends Button {
    private final boolean mine;
    private final color unrevealedColor;
    private final color revealedColor;
    private final color flagColor;
    private final color mineColor;
    private final GameManager gameManager;

    private boolean flagged = false;
    private boolean revealed = false;
    private int surroundingMines = 0;

    public Tile(float x, float y, float wid, float hei, int buttonShape, boolean mine, color unrevealedColor, color revealedColor, color flagColor, color mineColor, GameManager gameManager) {
        super(x, y, wid, hei, unrevealedColor, buttonShape);
        
        this.mine = mine;
        this.unrevealedColor = unrevealedColor;
        this.revealedColor = revealedColor;
        this.flagColor = flagColor;
        this.mineColor = mineColor;
        this.gameManager = gameManager;
    }

    public void draw() {
        if (revealed && mine) {
            col = mineColor;
        } else if (revealed) {
            col = revealedColor;
        } else if (flagged) {
            col = flagColor;
        } else {
            col = unrevealedColor;
        }

        super.draw();

        if (revealed && !mine) {
            text(surroundingMines, x, y);
        }
    }

    public void leftClick() {
        gameManager.leftClick(this);
    }

    public void rightClick() {
        gameManager.rightClick(this);
    }

    public void setRevealed(boolean b) {
        revealed = b;
    }

    public void setFlagged(boolean b) {
        flagged = b;
    }

    public boolean isMine() {
        return mine;
    }

    public boolean isRevealed() {
        return revealed;
    }

    public boolean isFlagged() {
        return flagged;
    }
}
