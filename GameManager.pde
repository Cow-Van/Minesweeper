public class GameManager {
    public final float TILE_WIDTH = 25;
    public final float TILE_HEIGHT = 25;
    public final float TILE_MARGIN = 2.5;

    private final GuiManager guiManager;

    private Tile[][] board = new Tile[0][0];
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

    }

    public void rightClick(Tile tile) {

    }

    public void reset() {
        board = new Tile[nextBoardRows][nextBoardCols];

        float totalTileWidth = TILE_MARGIN * 2 + TILE_WIDTH;
        float totalTileHeight = TILE_MARGIN * 2 + TILE_HEIGHT;
        float boardWidth = nextBoardRows * totalTileWidth;
        float boardHeight = nextBoardCols * totalTileHeight;
        float boardTopLeftX = width / 2 - boardWidth / 2;
        float boardTopLeftY = height / 2 - boardHeight / 2;

        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                println(boardTopLeftX + " " + boardTopLeftY);
                Tile tile = new Tile(boardTopLeftX + i * totalTileWidth + totalTileWidth / 2, boardTopLeftY + j * totalTileHeight + totalTileHeight / 2, TILE_WIDTH, TILE_HEIGHT, ButtonShape.RECTANGLE, false, color(0, 0, 0), color(0, 0, 0), color(0, 0, 0), color(0, 0, 0), guiManager);
                guiManager.registerButton(0, tile);
                board[i][j] = tile;
            }
        }
    }

    public void setBoardSize(int col, int row) {
        nextBoardCols = col;
        nextBoardRows = row;
    }
}