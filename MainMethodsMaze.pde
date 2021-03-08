class MainMethodsMaze extends Stage {
  class MainMethod {
    final String[] returnTypes = {"void ", "Void ", "int ", "String ", "" };
    final String[] methodNames = {"main(", "Main(", "mian("};
    final String[] parameterTypes = {"String[] ", "String... ", "String ", "void "};
    final String[] parameterNames = {"args){}", "arg){}", "x){}", "main){}", "$tuff){}", "input_parameters){}"};
    String method;
    boolean valid;

    MainMethod() {
      this.valid = (int)random(2) == 0 ? true : false;

      String md = "";
      String rt;
      String mn;
      String pt;
      String pn;
      if ((int)random(6) == 0) {
        int rv = (int)random(6);
        switch(rv) {
        case 0 :
          {
            md = "public final static ";
            break;
          }
        case 1 :
          {
            md = "public static final ";
            break;
          }
        case 2 :
          {
            md = "final public static ";
            break;
          }
        case 3 :
          {
            md = "final static public ";
            break;
          }
        case 4 :
          {
            md = "static public final ";
            break;
          }
        case 5 :
          {
            md = "static final public ";
            break;
          }
        }
      } else {
        if ((int)random(5) != 0) {
          md = "public static ";
        } else {
          md = "static public ";
        }
      }
      rt = returnTypes[0];
      mn = methodNames[0];
      pt = parameterTypes[(int)random(2)];
      pn = parameterNames[(int)random(6)];
      if (!valid) {
        int rv = (int)random(5);
        switch(rv) {
        case 0:
          {
            rt = returnTypes[(int)random(1, 5)];
            break;
          }
        case 1:
          {
            mn = methodNames[(int)random(1, 3)];
            break;
          }
        case 2:
          {
            pt = parameterTypes[(int)random(2, 4)];
            break;
          }
        case 3:
          {
            pn = JAVA_KEYWORDS[(int)random(JAVA_KEYWORDS.length)] + "){}";
            break;
          }
        case 4:
          {
            int vv = (int)random(6);
            switch(vv) {
            case 0 :
              {
                md = "static ";
                break;
              }
            case 1 :
              {
                md = "public ";
                break;
              }
            case 2 :
              {
                md = "final static ";
                break;
              }
            case 3 :
              {
                md = "final public ";
                break;
              }
            case 4 :
              {
                md = "public final ";
                break;
              }
            case 5 :
              {
                md = "static final ";
                break;
              }
            }
            break;
          }
        }
      }
      method = md + rt + mn + pt + pn;
    }

    void render(int cellX, int cellY, color c) {
      fill(c);
      textFont(courier);
      float h = 24;
      textSize(h);
      float w = textWidth(method);
      float xp = (cellX * resolutionWidth) + resolutionWidth / 2 - w / 2 - camera.x;
      float yp = (cellY * resolutionHeight) + 200 - camera.y;
      rect(xp - 2, yp, w, h + (h / 2));
      fill(255);
      text(method, xp, yp + h);
      textFont(arial);
    }

    void render(int cellX, int cellY) {
      render(cellX, cellY, color(50, 100, 200));
    }
  }

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
    static final float WALL_THICKNESS = 50;
    static final float WALL_WIDTH = resolutionWidth;
    static final float WALL_HEIGHT = resolutionHeight;
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
          float hw = WALL_THICKNESS / 2;
          if (c.north) {
            walls.add(new SolidBlock(i * WALL_WIDTH, j * WALL_HEIGHT - hw, WALL_WIDTH, WALL_THICKNESS));
          }
          if (c.south) {
            walls.add(new SolidBlock(i * WALL_WIDTH, j * WALL_HEIGHT + WALL_HEIGHT - hw, WALL_WIDTH, WALL_THICKNESS));
          }
          if (c.west) {
            walls.add(new SolidBlock(i * WALL_WIDTH - hw, j * WALL_HEIGHT, WALL_THICKNESS, WALL_HEIGHT));
          }
          if (c.east) {
            walls.add(new SolidBlock(i * WALL_WIDTH + WALL_WIDTH - hw, j * WALL_HEIGHT, WALL_THICKNESS, WALL_HEIGHT));
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
  }

  final int searchState = 0;
  final int greetingState = 1;
  final int inquireState = 2;
  final int inquireState2 = 3;
  final int mazeSearchState = 4;
  final int tutorialState = 5;
  final int mazeInquireState = 6;
  int mazeWidth = 5;
  int mazeHeight = 5;

  int mazeExitX;
  int mazeExitY;

  int wrongAnswers;

  int cellX;
  int cellY;
  boolean[][] completedCells;

  boolean wrongAnswer;

  Background background;

  Maze maze;
  SolidBlock[] blockWalls;
  PImage hedgeWall;
  MainMethod mainMethod;

  MainMethodsMaze(StageImage image) {

    super(image);

    host = loadImage("snail.png");
    hedgeWall = loadImage("hedge_wall.png");
    x = image.x;
    y = image.y;
    exitX = 100;
    exitY = 100;
    exitW = 50;
    exitH = 90;
    hostX = 500;
    hostY = 300;

    mazeExitX = resolutionWidth * mazeWidth - 200;
    mazeExitY = resolutionHeight * mazeHeight - 200;

    player.x = 100;
    player.y = 100;
    camera.x = 0;
    camera.y = 0;

    maze = new Maze(mazeWidth, mazeHeight);
    completedCells = new boolean[mazeWidth][mazeHeight];
    completedCells[0][0] = true;
    completedCells[mazeWidth - 1][mazeHeight - 1] = true;

    blockWalls = new SolidBlock[4];
    blockWalls[0] = new SolidBlock(0, 0, resolutionWidth, Maze.WALL_THICKNESS);
    blockWalls[1] = new SolidBlock(0, resolutionHeight, resolutionWidth, Maze.WALL_THICKNESS);
    blockWalls[2] = new SolidBlock(0, 0, Maze.WALL_THICKNESS, resolutionHeight);
    blockWalls[3] = new SolidBlock(resolutionWidth, 0, Maze.WALL_THICKNESS, resolutionHeight);
    background = new Background(resolutionWidth, resolutionHeight);
    background.clr = color(0, 128, 32);
    currentBackground = background;
  }

  boolean update() {
    boolean ret = true;
    fill(200);
    float cx = hostX - camera.x;
    float cy = hostY - camera.y;
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);
    image(host, cx, cy, host.width, host.height);
    switch(currentStageState) {
    case searchState:
      {
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Snail", cx, cy); 
          if (checkInteraction()) {
            currentStageState = greetingState;
          }
        }
        break;
      }
    case greetingState:
      {
        renderTextBox("Do you wanna learn about main methods?");
        if (renderDialogChoice("Yep")) {
          currentStageState = inquireState;
        }
        if (renderDialogChoice("Nope")) {
          currentStageState = mazeSearchState;
          background.w = resolutionWidth * maze.mw;
          background.h = resolutionHeight * maze.mh;
        }
        break;
      }
    case inquireState:
      {
        renderTextBox("The main method is how the Java Virtual Machine, or JVM, knows where to start", 
          "running a Java program. It is called the entry point to the JVM. Every", 
          "Java program must have a main method. Since the main method", 
          "is so important, it has to follow a certain standard. Main methods", 
          "must be public, static, and have a return type of void. They can", 
          "be final, although it is not a requirement.");
        if (renderDialogChoice("Okay.")) {
          currentStageState = inquireState2;
        }

        break;
      }
    case inquireState2:
      {
        renderTextBox("The name of the method", 
          "must be \"main\" with a lowercase \'m\'. The parameters must either", 
          "be an array of Strings or String variable arguments (String... x).", 
          "The name of the parameter can be any valid Java variable name. Talk", 
          "to the Octopus to learn more about those. A Java program can have", 
          "other methods named \"main\", but if they don't fit all of the previously", 
          "mentioned criteria, then they won't be a JVM entry point.");
        if (renderDialogChoice("Okay.")) {
          currentStageState = tutorialState;
        }

        break;
      }
    case tutorialState:
      {
        renderTextBox("Select only the proper main methods to escape.", 
          "Be vary carful! 3 wrong answers will reset the maze.");
        if (renderDialogChoice("What maze?")) {
          currentStageState = mazeSearchState;
          background.w = resolutionWidth * maze.mw;
          background.h = resolutionHeight * maze.mh;
        }
        if (renderDialogChoice("Wait. What's a main method again?")) {
          currentStageState = inquireState;
        }

        break;
      }
    case mazeSearchState:
      {
        boolean changedCell = false;
        if (player.x + camera.x > cellX * resolutionWidth + resolutionWidth) {
          cellX++; 
          changedCell = true;
        } else if (player.x + camera.x + player.w < cellX * resolutionWidth) {
          cellX--;
          changedCell = true;
        }
        if (player.y + camera.y > cellY * resolutionHeight + resolutionHeight) {
          cellY++; 
          changedCell = true;
        } else if (player.y + camera.y + player.h < cellY * resolutionHeight) {
          cellY--;
          changedCell = true;
        }
        if (changedCell && !completedCells[cellX][cellY]) {
          currentStageState = mazeInquireState;
          float ht = Maze.WALL_THICKNESS / 2;
          blockWalls[0].x = cellX * resolutionWidth;
          blockWalls[0].y = cellY * resolutionHeight - ht;
          blockWalls[1].x = cellX * resolutionWidth;
          blockWalls[1].y = cellY * resolutionHeight + resolutionHeight - ht;
          blockWalls[2].x = cellX * resolutionWidth - ht;
          blockWalls[2].y = cellY * resolutionHeight;
          blockWalls[3].x = cellX * resolutionWidth + resolutionWidth - ht;
          blockWalls[3].y = cellY * resolutionHeight;
          mainMethod = new MainMethod();
        }

        float mex = mazeExitX - camera.x;
        float mey = mazeExitY - camera.y;
        renderMaze();
        fill(200);
        rect(mazeExitX - camera.x, mazeExitY - camera.y, 50, 100);
        if (checkIntersection(player.x, player.y, player.w, player.h, mex, mey, 50, 100)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to Exit the Maze", mex - 100, mey);
          if (checkInteraction()) {
            //camera.x = image.x - camera.xMargin;
            //camera.y = image.y - resolutionHeight + image.image.height;
            //player.x = image.x + image.image.width;
            //player.y = image.y + image.image.height;
            //currentBackground = worldMapBackground;
            //currentState = GameStates.WORLD_MAP_STATE;
            image.completed = true;          
            returnToWorld();

            ret = false;
          }
        }


        break;
      }
    case mazeInquireState:
      {
        //if(keyPressed && key == ' '){
        //  keyPressed = false;
        //  key = 0;
        //  completedCells[cellX][cellY] = true;
        //  currentStageState = mazeSearchState;
        //  mainMethod = null;
        //}
        if (wrongAnswer) {
          mainMethod.render(cellX, cellY, color(220, 70, 70));
          if (renderPlayerButton("TRY AGAIN", "Press Space to Try Again", (cellX * resolutionWidth) + 380, cellY * resolutionHeight + 400)) {
            mainMethod = new MainMethod();
            wrongAnswer = false;
          }
        } else {
          mainMethod.render(cellX, cellY);
          if (renderPlayerButton("VALID", "Press Space if Main Method is Good", (cellX * resolutionWidth) + 300, cellY * resolutionHeight + 400)) {
            if (mainMethod.valid) {
              completedCells[cellX][cellY] = true;
              currentStageState = mazeSearchState;
              mainMethod = null;
            } else {
              wrongAnswer = true;
              wrongAnswers++;
            }
          }
          if (renderPlayerButton("INVALID", "Press Space if Main Method is Bad", (cellX * resolutionWidth) + 600, cellY * resolutionHeight + 400)) {
            if (!mainMethod.valid) {
              completedCells[cellX][cellY] = true;
              currentStageState = mazeSearchState;
              mainMethod = null;
            } else {
              wrongAnswer = true;
              wrongAnswers++;
            }
          }

          if (wrongAnswers >= 3) {
            maze = new Maze(mazeWidth, mazeHeight); 
            player.x = 100;
            player.y = 100;
            camera.x = 0;
            camera.y = 0;
            cellX = 0;
            cellY = 0;
            mainMethod = null;
            wrongAnswers = 0;
            wrongAnswer = false;
            currentStageState = mazeSearchState;
            for (int i = 0; i < mazeWidth; i++) {
              for (int j = 0; j < mazeHeight; j++) {
                completedCells[i][j] = false;
              }
            }
            completedCells[0][0] = true;
            completedCells[mazeWidth - 1][mazeHeight - 1] = true;
          }
        }
        for (int i = 0; i < blockWalls.length; i++) {
          SolidBlock w = blockWalls[i];
          image(hedgeWall, w.x - camera.x, w.y - camera.y, w.w, w.h);
          handleSolidBlockCollision(w);
        }
        renderMaze();
        fill(200);
        rect(mazeExitX - camera.x, mazeExitY - camera.y, 50, 100);

        //if(keyPressed && key == ' '){
        //  key = 0;
        //  completedCells[cellX][cellY] = true;
        //    currentStageState = mazeSearchState;
        //    mainMethod = null;
        //}



        break;
      }
    }

    if (checkForExit()) {
      if (checkInteraction()) {
        returnToWorld();
        ret = false;
      }
    }
    return ret;
  }

  void renderMaze() {
    for (SolidBlock b : maze.walls) {
      image(hedgeWall, b.x - camera.x, b.y - camera.y, b.w, b.h);
      handleSolidBlockCollision(b);
    }
  }
}
