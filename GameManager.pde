public class GameManager {
    public static final float TILE_WIDTH = 25;
    public static final float TILE_HEIGHT = 25;
    public static final float TILE_MARGIN = 2.5;
    public static final color UNREVEALED_COLOR = color(0);
    public static final color REVEALED_COLOR = color(100);
    public static final color FLAG_COLOR = color(255, 0, 0);
    public static final color MINE_COLOR = color(0, 255, 0);
    public static final float MINE_PERCENTAGE = 0.2;
    public static final int MINE_GENERATION_SAFE_RADIUS = 1;

    private final GuiManager guiManager;

    private Tile[][] board = new Tile[0][0];
    private int totalTiles = 0;
    private int nextBoardCols = 0;
    private int nextBoardRows = 0;
    private int totalMines = 0;
    private int minesFlagged = 0;
    private int safeTilesFlagged = 0;
    private int totalSafeTiles = 0;
    private int safeTilesRevealed = 0;
    private boolean firstClick = true;
    private boolean gameOver = false;
    private boolean win = false;

    public GameManager(GuiManager guiManager) {
        this.guiManager = guiManager;
    }

    public void draw() {
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                board[i][j].draw();
            }
        }

        win = totalMines != 0 && safeTilesFlagged == 0 && (totalMines == minesFlagged || totalSafeTiles == safeTilesRevealed);
        gameOver = gameOver || win;

        if (gameOver) {
            if (win) {
                text("You win! Press R to reset", width / 2, height - 30);
            } else {

                text("You lose! Press R to reset", width / 2, height - 30);
            }
        }
    }

    public void leftClick(Tile tile) {
        if (tile.isFlagged() || gameOver) {
            return;
        }

        if (firstClick) {
            generateMines((int) (totalTiles * MINE_PERCENTAGE), tile.getBoardX(), tile.getBoardY(), MINE_GENERATION_SAFE_RADIUS);
            firstClick = false;
        }

        if (tile.isMine()) {
            gameOver = true;
            win = false;
            revealAllMines();
            return;
        }

        tile.setRevealed(true);
        safeTilesRevealed++;

        if (tile.getSurrondingMines() == 0) {
            revealNeighbors(tile);
        }
    }

    public void rightClick(Tile tile) {
        if (tile.isRevealed() || firstClick || gameOver) {
            return;
        }

        if (tile.isMine()) {
            minesFlagged += tile.isFlagged() ? -1 : 1;
        } else {
            safeTilesFlagged += tile.isFlagged() ? -1 : 1;
        }

        tile.setFlagged(!tile.isFlagged());
    }

    public void reset() {
        board = new Tile[nextBoardRows][nextBoardCols];
        totalTiles = nextBoardRows * nextBoardCols;

        float totalTileWidth = TILE_MARGIN * 2 + TILE_WIDTH;
        float totalTileHeight = TILE_MARGIN * 2 + TILE_HEIGHT;
        float boardWidth = nextBoardRows * totalTileWidth;
        float boardHeight = nextBoardCols * totalTileHeight;
        float boardTopLeftX = width / 2 - boardWidth / 2;
        float boardTopLeftY = height / 2 - boardHeight / 2;

        guiManager.clearButtons(0);

        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                Tile tile = new Tile(boardTopLeftX + i * totalTileWidth + totalTileWidth / 2, boardTopLeftY + j * totalTileHeight + totalTileHeight / 2, TILE_WIDTH, TILE_HEIGHT, ButtonShape.RECTANGLE, UNREVEALED_COLOR, REVEALED_COLOR, FLAG_COLOR, MINE_COLOR, j, i, this);
                guiManager.registerButton(0, tile);
                board[i][j] = tile;
            }
        }

        firstClick = true;
        totalMines = 0;
        minesFlagged = 0;
        totalSafeTiles = 0;
        safeTilesRevealed = 0;
        firstClick = true;
        gameOver = false;
        win = false;
    }

    public void setBoardSize(int col, int row) {
        nextBoardCols = col;
        nextBoardRows = row;
    }

    private boolean generateMines(int mines, int xStart, int yStart, int safeRadius) {
        ArrayList<Tile> mineableTiles = new ArrayList<Tile>();

        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                if (!(j >= xStart - safeRadius && j <= xStart + safeRadius && i >= yStart - safeRadius && i <= yStart + safeRadius)) {
                    mineableTiles.add(board[i][j]);
                }
            }
        }

        if (mines > mineableTiles.size()) {
            return false;
        }

        for (int i = 0; i < mines; i++) {
            Tile minedTile = mineableTiles.get((int) random(mineableTiles.size()));
            minedTile.setMine(true);
            mineableTiles.remove(minedTile);

            incrementNeighborsSurrondingMines(minedTile);
        }

        totalMines = mines;
        totalSafeTiles = totalTiles - totalMines;

        return true;
    }

    private void incrementNeighborsSurrondingMines(Tile tile) {
        for (int i = -1; i <= 1; i++) {
            if (tile.getBoardY() + i < 0 || tile.getBoardY() + i >= board.length) {
                continue;
            }

            for (int j = -1; j <= 1; j++) {
                if (tile.getBoardX() + j < 0 || tile.getBoardX() + j >= board[tile.getBoardY() + i].length || (i == 0 && j == 0)) {
                    continue;
                }

                board[tile.getBoardY() + i][tile.getBoardX() + j].setSurrondingMines(board[tile.getBoardY() + i][tile.getBoardX() + j].getSurrondingMines() + 1);
            }
        }
    }

    private void revealNeighbors(Tile tile) {
        for (int i = -1; i <= 1; i++) {
            if (tile.getBoardY() + i < 0 || tile.getBoardY() + i >= board.length) {
                continue;
            }

            for (int j = -1; j <= 1; j++) {
                if (tile.getBoardX() + j < 0 || tile.getBoardX() + j >= board[tile.getBoardY() + i].length || (i == 0 && j == 0) || board[tile.getBoardY() + i][tile.getBoardX() + j].isRevealed()) {
                    continue;
                }

                leftClick(board[tile.getBoardY() + i][tile.getBoardX() + j]);
            }
        }
    }

    private void revealAllMines() {
        for (int i = 0; i < board.length; i++) { // TODO make more efficient
            for (int j = 0; j < board[i].length; j++) {
                if (board[i][j].isMine()) {
                    board[i][j].setRevealed(true);
                }
            }
        }
    }
}
