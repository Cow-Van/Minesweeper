public class GameManager {
    public final float TILE_WIDTH = 25;
    public final float TILE_HEIGHT = 25;
    public final float TILE_MARGIN = 2.5;
    public final color UNREVEALED_COLOR = color(0);
    public final color REVEALED_COLOR = color(100);
    public final color FLAG_COLOR = color(255, 0, 0);
    public final color MINE_COLOR = color(0, 255, 0);
    public final float MINE_PERCENTAGE = 0.5;
    public final int MINE_GENERATION_SAFE_RADIUS = 1;

    private final GuiManager guiManager;

    private Tile[][] board = new Tile[0][0];
    private int totalTiles = 0;
    private int nextBoardCols = 0;
    private int nextBoardRows = 0;
    private boolean firstClick = true;

    public GameManager(GuiManager guiManager) {
        this.guiManager = guiManager;
    }

    public void draw() {
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                board[i][j].draw();
            }
        }
    }

    public void leftClick(Tile tile) {
        if (tile.isFlagged()) {
            return;
        }

        if (firstClick) {
            generateMines((int) (totalTiles * MINE_PERCENTAGE), tile.getBoardX(), tile.getBoardY(), MINE_GENERATION_SAFE_RADIUS);
            firstClick = false;
        }

        tile.setRevealed(true);
    }

    public void rightClick(Tile tile) {
        if (tile.isRevealed() || firstClick) {
            return;
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

        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                Tile tile = new Tile(boardTopLeftX + i * totalTileWidth + totalTileWidth / 2, boardTopLeftY + j * totalTileHeight + totalTileHeight / 2, TILE_WIDTH, TILE_HEIGHT, ButtonShape.RECTANGLE, UNREVEALED_COLOR, REVEALED_COLOR, FLAG_COLOR, MINE_COLOR, j, i, this);
                guiManager.registerButton(0, tile);
                board[i][j] = tile;
                tile.setRevealed(true);
            }
        }

        firstClick = true;
    }

    public void setBoardSize(int col, int row) {
        nextBoardCols = col;
        nextBoardRows = row;
    }

    private boolean generateMines(int mines, int xStart, int yStart, int safeRadius) {
        ArrayList<Tile> mineableTiles = new ArrayList<Tile>();

        for (int i = 0; i < board.length; i++) { // TODO FIX
            for (int j = 0; j < board[i].length; j++) {
                if (!(j > xStart - safeRadius && j < xStart + safeRadius && i > yStart - safeRadius && i < yStart + safeRadius)) {
                    mineableTiles.add(board[i][j]);
                }
            }
        }

        println(mineableTiles.size());

        if (mines > mineableTiles.size()) {
            return false;
        }

        for (int i = 0; i < mines; i++) {
            Tile minedTile = mineableTiles.get((int) random(mineableTiles.size()));
            minedTile.setMine(true);
            mineableTiles.remove(minedTile);
        }

        return true;
    }
}
