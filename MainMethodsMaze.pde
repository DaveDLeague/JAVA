class MainMethodsMaze extends Stage {
  class Maze {
    class Cell {
      int x;
      int y;
      boolean visited;
      boolean north = true;
      boolean south = true;
      boolean east = true;
      boolean west = true;

      Cell(int x, int y) {
        this.x = x;
        this.y = y;
      }
    }
    static final float WALL_WIDTH = 10;
    static final float WALL_LENGTH = 100;
    float x;
    float y;
    int mw;
    int mh;

    Cell[][] cells;
    ArrayList<SolidBlock> walls;
    Stack<Cell> uncheckedCells;

    Maze(int w, int h) {
      this.mw = w;
      this.mh = h;

      walls = new ArrayList<SolidBlock>();
      cells = new Cell[mw][mh];
      for (int i = 0; i < mw; i++) {
        for (int j = 0; j < mh; j++) {
          cells[i][j] = new Cell(i, j);
        }
      }

      Cell rc = cells[(int)random(mw)][(int)random(mh)];

      uncheckedCells = new Stack<Cell>();
      generateMaze(rc);

      for (int i = 0; i < mw; i++) {
        for (int j = 0; j < mh; j++) {
          Cell c = cells[i][j];
          if (c.north) {
            walls.add(new SolidBlock(i * WALL_LENGTH, j * WALL_LENGTH, WALL_LENGTH, WALL_WIDTH));
          }
          if (c.south) {
            walls.add(new SolidBlock(i * WALL_LENGTH, j * WALL_LENGTH + WALL_LENGTH, WALL_LENGTH, WALL_WIDTH));
          }
          if (c.west) {
            walls.add(new SolidBlock(i * WALL_LENGTH, j * WALL_LENGTH, WALL_WIDTH, WALL_LENGTH));
          }
          if (c.east) {
            walls.add(new SolidBlock(i * WALL_LENGTH + WALL_LENGTH, j * WALL_LENGTH, WALL_WIDTH, WALL_LENGTH));
          }
        }
      }
      for (int i = 0; i < walls.size() - 1; i++) {
        for (int j = i + 1; j < walls.size(); j++) {
          SolidBlock b1 = walls.get(i);
          SolidBlock b2 = walls.get(j);
          if (b1.x == b2.x && b1.y == b2.y && b1.w == b2.w && b1.h == b2.h) {
            walls.remove(j);
            j--;
          }
        }
      }
      cells = null;
      uncheckedCells = null;
    }

    void generateMaze(Cell c) {
      c.visited = true;
      ArrayList<Cell> nb = getUnvisitedNeighbors(c);

      if (nb.size() > 0) {
        Cell nc = nb.get((int)random(nb.size()));
        uncheckedCells.push(nc);
        removeWalls(c, nc);
        generateMaze(nc);
      } else {
        if (!uncheckedCells.isEmpty()) {
          generateMaze(uncheckedCells.pop());
        }
      }
    }

    ArrayList<Cell> getUnvisitedNeighbors(Cell c) {
      int x = c.x;
      int y = c.y;

      ArrayList<Cell> unvisitedNeighbors = new ArrayList<Cell>();

      if (x > 0 && !cells[x - 1][y].visited) {
        unvisitedNeighbors.add(cells[x - 1][y]);
      }

      if (y > 0 && !cells[x][y - 1].visited) {
        unvisitedNeighbors.add(cells[x][y - 1]);
      }

      if (x < mw - 1 && !cells[x + 1][y].visited) {
        unvisitedNeighbors.add(cells[x + 1][y]);
      }

      if (y < mh - 1 && !cells[x][y + 1].visited) {
        unvisitedNeighbors.add(cells[x][y + 1]);
      }

      return unvisitedNeighbors;
    }

    void removeWalls(Cell c1, Cell c2) {
      if (c1.x == c2.x) {
        if (c1.y > c2.y) {
          c1.north = false;
          c2.south = false;
        } else {
          c2.north = false;
          c1.south = false;
        }
      } else {
        if (c1.x > c2.x) {
          c1.west = false;
          c2.east = false;
        } else {
          c2.west = false;
          c1.east = false;
        }
      }
    }

    void render() {
      fill(0, 255, 0);

      for (SolidBlock b : walls) {
        rect(b.x - camera.x, b.y - camera.y, b.w, b.h);
        handleSolidBlockCollision(b);
      }
    }
  }

  final int searchState = 0;
  final int greetingState = 1;
  final int inquireState = 2;
  final int gatherState = 3;
  final int checkState = 4;

  Maze maze;

  MainMethodsMaze(StageImage image) {
    super(image);
    host = loadImage("snail.png");
    x = image.x;
    y = image.y;
    exitX = x;
    exitY = y;
    exitW = 50;
    exitH = 90;
    hostX = 900;
    hostY = 500;

    maze = new Maze(10, 10);
  }

  public boolean update() {
    boolean ret = true;
    background(0, 128, 32);
    fill(200);
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);
    image(host, hostX - camera.x, hostY - camera.y, host.width, host.height);
    switch(currentStageState) {
    case searchState:
      {
        maze.render();
        break;
      }
    }

    if (checkForExit()) {
      if (keyPressed && key == ' ') {
        currentState = GameStates.WORLD_MAP_STATE;
        ret = false;
        key = 0;
      }
    }
    return ret;
  }
}
