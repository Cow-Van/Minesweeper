public class GameManager {
    private Tile[][] board = new Tile[0][0];
    private int nextBoardWidth = 0;
    private int nextBoardHeight = 0;

    public GameManager() {}

    public void draw() {
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board.length; j++) {
                board[i][j].draw();
            }
        }
    }

    public void reset() {
        board = new Tile[nextBoardHeight][nextBoardWidth];
    }

    public void setBoardSize(int wid, int hei) {
        nextBoardWidth = wid;
        nextBoardHeight = hei;
    }
}