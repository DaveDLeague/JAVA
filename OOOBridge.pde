class OOOBridge extends Stage {
  class OperationTile {
    String op;
    float x; 
    float y;
    float w;
    float h;

    float th;
    float tw;

    boolean onPath;
    OperationTile(float x, float y, float w, float h) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;

      int r = (int)random(OPERATIONS.length);
      int s = (int)random(OPERATIONS[r].length);
      op = OPERATIONS[r][s];
      textFont(courier);
      th = 96;
      boolean good = false;
      while (!good) {
        textSize(th);
        tw = textWidth(op);
        if (tw < w - 3 && th < h - 15) good = true;
        else th--;
      }

      textFont(arial);
    }
  }

  class OOOLevel {
    ArrayList<OperationTile> tiles = new ArrayList<OperationTile>();
    float y;
    int tilesPerRow = 15;
    int tilesPerColumn;
    float tw = resolutionWidth / tilesPerRow;
    OOOLevel() {
      float xp = 0;
      float yp = 0;
      boolean done = false;
      while (!done) {
        OperationTile t = new OperationTile(xp, yp, tw, tw);
        tiles.add(t);
        xp += tw;
        if (xp + tw > resolutionWidth) {
          xp = 0;
          yp += tw;
          tilesPerColumn++;
        }
        if (yp + tw > resolutionHeight - tw) {
          done = true;
        }
      }

      int txp = (int)random(tilesPerRow);
      int typ = 0;
      tileAt(txp, typ).onPath = true;
      typ++;
      tileAt(txp, typ).onPath = true;

      while (typ < tilesPerColumn - 1) {
        boolean nf = true;
        while (nf) {
          int c = (int)random(3);
          int nx = txp;
          int ny = typ;
          if (c == 0) {
            nx -= 1;
          } else if (c == 1) {
            ny += 1;
          } else {
            nx += 1;
          }

          if (nx < 0 || nx > tilesPerRow - 1 ||
            ny < 0) continue;
          else if (!tileAt(nx, ny).onPath) {
            txp = nx;
            typ = ny;
            tileAt(txp, typ).onPath = true;
            nf = false;
          }
        }
      }
    }



    void render() {
      textFont(courier);
      for (OperationTile t : tiles) {
        if (t.onPath)fill(200, 100, 50);
        else fill(100, 100, 50);
        rect(t.x, y + t.y, t.w, t.h);
        fill(30);
        textSize(t.th);
        float ty = y + t.y + t.th;
        text(t.op, t.x + (t.w / 2) - (t.tw / 2), ty);
      }
      textFont(arial);
    }

    OperationTile tileAt(int x, int y) {
      return tiles.get(y * tilesPerRow + x);
    }
  }

  final int searchState = 0;
  final int greetingState = 1;
  final int findStartState = 2;
  final int playGameState = 3;
  final int cameraPanState = 4;
  final int playerTransitionState = 5;

  float playerXDest;
  float playerYDest;

  float cameraPanSpeed = 10;

  boolean uok;
  boolean dok;
  boolean lok;
  boolean rok;

  OOOLevel level;
  OOOLevel plevel;
  OOOBridge(StageImage image) {
    super(image);

    host = loadImage("bird.png");

    exitX = 500;
    exitY = 300;
    exitW = 50;
    exitH = 90;
    hostX = exitX + 200;
    hostY = exitY;
    player.x = exitX;
    player.y = exitY;
    background = new Background(resolutionWidth, resolutionHeight);
    currentBackground = background;
    background.clr = color(25, 100, 200);

    currentStageState = findStartState;
  }

  boolean update() {
    boolean ret = true;

    float cx = hostX - camera.x;
    float cy = hostY - camera.y;
    fill(200);
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);
    image(host, cx, cy, host.width, host.height);

    switch(currentStageState) {
    case searchState:
      {
        player.update();
        camera.update();
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Bird", cx, cy); 
          if (checkInteraction()) {
            currentStageState = greetingState;
          }
        }
        break;
      }
    case greetingState:
      {
        player.update();
        camera.update();
        renderTextBox("Wut up widdit?");
        if (renderDialogChoice("Okay!")) {
        }
        if (renderDialogChoice("Yo!")) {
        }
        break;
      }
      case findStartState:
      {
        player.update();
        camera.update();
        if (player.y <= 0) {
          level = new OOOLevel();
          level.y = -resolutionHeight;
          int cellx = (int)(player.x / level.tw);
          player.x = (cellx * level.tw) + ((level.tw / 2) - (player.w / 2));
          currentStageState = cameraPanState;
          background.h += resolutionHeight;
        }  
        break;
      }
    case playGameState:
      {
        if (player.up && uok) {
          playerYDest = player.y - level.tw;
          playerXDest = player.x;
          currentStageState = playerTransitionState;
          uok = false;
        } else if (!player.up) {
          uok = true;
        }
        if (player.down && dok) {
          playerYDest = player.y + level.tw;
          playerXDest = player.x;
          currentStageState = playerTransitionState;
          dok = false;
        } else if (!player.down) {
          dok = true;
        }
        if (player.left && lok) {
          playerXDest = player.x - level.tw;
          playerYDest = player.y;
          currentStageState = playerTransitionState;
          lok = false;
        } else if (!player.left) {
          lok = true;
        }
        if (player.right && rok) {
          playerXDest = player.x + level.tw;
          playerYDest = player.y;
          currentStageState = playerTransitionState;
          rok = false;
        } else if (!player.right) {
          rok = true;
        }
        if (player.y <= 0) {
          currentStageState = cameraPanState;
          background.h += resolutionHeight;
          plevel = level;
          level = new OOOLevel();
          level.y = -resolutionHeight;
        }  
        //player.update();
        //camera.update();
        

        if (level != null) {
          level.render();
        }
        //if (plevel != null) {
        //  plevel.render();
        //}
        break;
      }
    case cameraPanState:
      {
        camera.y -= cameraPanSpeed;
        exitY += cameraPanSpeed;
        hostY += cameraPanSpeed;
        level.y += cameraPanSpeed;

        if (player.y + player.h < resolutionHeight) {
          player.y += cameraPanSpeed;
        }
        if (camera.y <= -resolutionHeight) {

          currentStageState = playGameState; 
          background.h = resolutionHeight;
          player.y = ((int)(player.y / level.tw) * level.tw) + ((level.tw / 2) - (player.h / 2));
          camera.y = 0;
          level.y = 0;
          plevel = null;
        }
        level.render();
        if (plevel != null) {
          plevel.y += cameraPanSpeed;
          plevel.render();
        }
        break;
      }
    case playerTransitionState:
      {
        float s = 5;
        boolean fin = false;
        if (playerYDest < player.y) {
          player.y -= s;
          if (player.y <= playerYDest) fin = true;
        } else if (playerYDest > player.y) {
          player.y += s;
          if (player.y >= playerYDest) fin = true;
        } else if (playerXDest < player.x) {
          player.x -= s;
          if (player.x <= playerXDest) fin = true;
        } else if (playerXDest > player.x) {
          player.x += s;
          if (player.x >= playerXDest) fin = true;
        }
        if (fin) {
          player.x = playerXDest;
          player.y = playerYDest;
          currentStageState = playGameState;
        }
        level.render();
        break;
      }
    }

    if (checkForExit() && checkInteraction()) {
      returnToWorld();
      ret = false;
    }

    return ret;
  }
}
