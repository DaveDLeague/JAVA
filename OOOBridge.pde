class OOOBridge extends Stage {
  class OperationTile {
    String op;
    float x; 
    float y;
    float w;
    float h;

    float th;
    float tw;

    int ranking;

    boolean onPath;
    OperationTile(float x, float y, float w, float h) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.ranking = (int)random(totalOperations);

      setRanking(ranking);
    }

    void setRanking(int ranking) {
      this.ranking = ranking; 
      this.op = getOperation(ranking);
      textFont(courier);
      th = 50;
      boolean good = false;
      while (!good) {
        textSize(th);
        tw = textWidth(op);
        if (tw < w - 3 && th < h - 15) good = true;
        else th--;
        if (th <= 1) good = true;
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



      int ctr = 0;
      ArrayList<OperationTile> pathTiles = new ArrayList<OperationTile>();
      pathTiles.add(tileAt(txp, typ));
      typ++;
      pathTiles.add(tileAt(txp, typ));
      pathTiles.get(0).setRanking(ctr++);
      pathTiles.get(1).setRanking(ctr++);
      while (typ < tilesPerColumn - 1) {
        boolean nf = true;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        while (nf) {///////////////////////////////////////////////////////////////////////////CHANGE THIS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
            pathTiles.add(tileAt(txp, typ));
            tileAt(txp, typ).onPath = true;
            nf = false;
          }
        }
      }

      int[] rns = new int[pathTiles.size()]; 
      int at = 0;
      while (at < rns.length) {
        int rv = (int)random(totalOperations); 
        boolean fd = false;
        for (int i = 0; i < at; i++) {
          if (rns[i] == rv) {
            fd = true;
            break;
          }
        }
        if (!fd) {
          rns[at] = rv;
          at++;
        }
      }
      Arrays.sort(rns);
      for (int i = rns.length - 1; i > -1; i--) {    

        pathTiles.get(i).setRanking(rns[i]);
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
      int idx = y * tilesPerRow + x;
      if (idx >= tiles.size()) return null;
      else return tiles.get(idx);
    }
  }

  class OOOQuestion {
    String question;
    double answer;

    OOOQuestion(int difficulty) {
      switch(difficulty) {
      case 0:
        {
          String symbol1 = (int)random(2) == 0 ? "+" : "-";
          String symbol2 = (int)random(2) == 0 ? "*" : "/";
          question = (int)random(1, 10) + " " + symbol1 + " " + (int)random(1, 10) + " " + symbol2 + " " + (int)random(1, 10);
          break;
        }
      case 1:
        {
          String symbol1 = (int)random(2) == 0 ? "+" : "-";
          String symbol2 = (int)random(2) == 0 ? "*" : "/";
          question = (int)random(1, 10) + " " + symbol1 + " " + (int)random(1, 10) + " " + symbol2 + " " + (int)random(1, 10);
          break;
        }
      }


      try {
        Object o = functionEvaluator.eval(question);
        try{
          answer = (Double)o;
        }catch(Exception e){
          answer = (Integer)o; 
        }
      }
      catch(Exception e) {
        e.printStackTrace();
      }
    }

    void render() {
    }
  }

  final int searchState = 0;
  final int greetingState = 1;
  final int findStartState = 2;
  final int playGameState = 3;
  final int cameraPanState = 4;
  final int playerTransitionState = 5;
  final int playerFallState = 6;
  final int fillInQuestionState = 7;

  float startPlayerX;
  float startPlayerY;
  float playerXDest;
  float playerYDest;

  float cameraPanSpeed = 10;

  int opDisplayYOffset;

  boolean uok;
  boolean dok;
  boolean lok;
  boolean rok;

  boolean tabOk = true;
  boolean displayOperatorsMode;

  OOOLevel level;
  OOOLevel plevel;
  OperationTile currentTile;
  OperationTile previousTile;

  OOOBridge(StageImage image) {
    super(image);

    for (int i = 0; i < 100; i++) {
      OOOQuestion q = new OOOQuestion(0);
      println(q.question + " = " + q.answer);
    }

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

    if (keyPressed && keyCode == TAB && tabOk) {
      displayOperatorsMode = !displayOperatorsMode;
      tabOk = false;
    } else if (!keyPressed) {
      tabOk = true;
    }


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
          previousTile = level.tileAt((int)(player.x / level.tw), (int)(player.y / level.tw));
          currentStageState = playerTransitionState;
          uok = false;
        } else if (!player.up) {
          uok = true;
        }
        if (player.down && dok) {
          float d = player.y + level.tw;
          if (d < resolutionHeight) {
            playerYDest = d;
            playerXDest = player.x;
            previousTile = level.tileAt((int)(player.x / level.tw), (int)(player.y / level.tw));
            currentStageState = playerTransitionState;
          }
          dok = false;
        } else if (!player.down) {
          dok = true;
        }
        if (player.left && lok) {
          float d = player.x - level.tw;
          if (d > 0) {
            playerXDest = d;
            playerYDest = player.y;
            previousTile = level.tileAt((int)(player.x / level.tw), (int)(player.y / level.tw));
            currentStageState = playerTransitionState;
          }
          lok = false;
        } else if (!player.left) {
          lok = true;
        }
        if (player.right && rok) {
          float d = player.x + level.tw;
          if (d < resolutionWidth) {
            playerXDest = player.x + level.tw;
            playerYDest = player.y;
            previousTile = level.tileAt((int)(player.x / level.tw), (int)(player.y / level.tw));
            currentStageState = playerTransitionState;
          }
          rok = false;
        } else if (!player.right) {
          rok = true;
        }
        if (player.y <= 0) {
          currentStageState = cameraPanState;
          currentTile = null;
          background.h += resolutionHeight;
          plevel = level;
          level = new OOOLevel();
          level.y = -resolutionHeight;
        }  

        if (level != null) {
          level.render();
        }

        if (plevel != null) {
          plevel.render();
        }
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
          startPlayerX = player.x;
          startPlayerY = player.y;
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
          currentTile = level.tileAt((int)(player.x / level.tw), (int)(player.y / level.tw));
          if (currentTile != null) {
            if (!currentTile.onPath) {
              currentTile.onPath = true;
              if (previousTile != null) {
                if (currentTile.ranking > previousTile.ranking) {
                  currentStageState = playerFallState;
                }
              }
            }
          }
          if (currentStageState != playerFallState) {
            currentStageState = playGameState;
          }
        }
        level.render();
        break;
      }
    case playerFallState:
      {
        float fallSpeed = 0.9f;
        float tx = (int)(player.x / level.tw) * level.tw;
        float ty = (int)(player.y / level.tw) * level.tw;
        if (currentTile.w > 0.001 && currentTile.h > 0.001) {
          currentTile.w *= fallSpeed;
          currentTile.h *= fallSpeed;
          currentTile.x = tx + (level.tw / 2) - (currentTile.w / 2);
          currentTile.y = ty + (level.tw / 2) - (currentTile.h / 2);

          currentTile.setRanking(currentTile.ranking);
        }

        //player.w = 0;
        //player.h = 0;
        if (player.w > 0.001 && player.h > 0.001) {
          player.w *= fallSpeed;
          player.h *= fallSpeed;
          player.x = tx + (level.tw / 2) - (player.w / 2);
          player.y = ty + (level.tw / 2) - (player.h / 2);
        } else {
          level = new OOOLevel();
          player.x = startPlayerX;
          player.y = startPlayerY;
          player.w = player.image.width;
          player.h = player.image.height;
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
    image(player.image, player.x, player.y, player.w, player.h);

    if (displayOperatorsMode) {
      opDisplayYOffset += scrollAmount * 20;
      fill(0, 0, 0, 200);
      float margin = 25;
      float mx2 = margin * 2;
      float idt = margin * 15;
      float bw = resolutionWidth - mx2;
      float br = margin + bw;
      strokeWeight(10);
      rect(margin, margin + opDisplayYOffset, bw, resolutionHeight - mx2, 20);
      strokeWeight(5);
      line(idt, margin + opDisplayYOffset, idt, margin + opDisplayYOffset + resolutionHeight - mx2);
      strokeWeight(1);

      fill(255);
      textSize(25);
      centeredText("Operator Type", margin, idt, 60);
      centeredText("Symbol", idt, br, 60);
    }

    return ret;
  }
}
