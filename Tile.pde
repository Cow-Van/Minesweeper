public class Tile extends Button {
    private final color unrevealedColor;
    private final color revealedColor;
    private final color flagColor;
    private final color mineColor;
    private final int boardX;
    private final int boardY;
    private final GameManager gameManager;

    private boolean mine = false;
    private boolean flagged = false;
    private boolean revealed = false;
    private int surroundingMines = 0;

    public Tile(float x, float y, float wid, float hei, int buttonShape, color unrevealedColor, color revealedColor, color flagColor, color mineColor, int boardX, int boardY, GameManager gameManager) {
        super(x, y, wid, hei, unrevealedColor, buttonShape);
        
        this.unrevealedColor = unrevealedColor;
        this.revealedColor = revealedColor;
        this.flagColor = flagColor;
        this.mineColor = mineColor;
        this.boardX = boardX;
        this.boardY = boardY;
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

        if (revealed && !mine && surroundingMines != 0) {
            textSize(20);
            fill(255, 0, 255);
            text(surroundingMines, x, y);
        }
    }

    public void leftClick() {
        gameManager.leftClick(this);
    }

    public void rightClick() {
        gameManager.rightClick(this);
    }

    public void setMine(boolean b) {
        mine = b;
    }

    public void setRevealed(boolean b) {
        revealed = b;
    }

    public void setFlagged(boolean b) {
        flagged = b;
    }

    public void setSurrondingMines(int n) {
        surroundingMines = n;
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

    public int getSurrondingMines() {
        return surroundingMines
    }

    public int getBoardX() {
        return boardX;
    }

    public int getBoardY() {
        return boardY;
    }
}
