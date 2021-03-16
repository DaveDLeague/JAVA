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
    int group;

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
      this.group = getOperationGroup(this.op);
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
    OOOQuestion fillInQuestion;
    boolean isFillIn = true;
    float y;
    int tilesPerRow = 15;
    int tilesPerColumn;
    float tw = resolutionWidth / tilesPerRow;
    color fillInQBoxColor = color(20, 20, 20, 200);

    OOOLevel(boolean isFill, int level) {
      if (isFill) {
        fillInQuestion = new OOOQuestion(level);
      } else {
        this.isFillIn = false;
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
        //pathTiles.get(0).onPath = true;
        //pathTiles.get(1).onPath = true;
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
              //tileAt(txp, typ).onPath = true;
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
        for (int i = 0; i < pathTiles.size(); i++) {    

          pathTiles.get(i).setRanking(rns[pathTiles.size() - 1 - i]);
        }
      }
    }

    OOOLevel() {
      this(false, 0);
    }

    void render() {
      textFont(courier);
      if (isFillIn) {
        float h = fillInQuestion.h;
        float w = fillInQuestion.w;
        float xp = resolutionWidth / 2 - w / 2;
        float yp = y + (resolutionHeight / 2 - h / 2);

        fill(fillInQBoxColor);
        rect(xp, yp, w, h);
        fill(0, 200, 200);
        textSize(fillInQuestion.h);
        text(fillInQuestion.question, xp, yp + h - 5);
      } else {
        for (OperationTile t : tiles) {
          if (t.onPath) fill(200, 100, 50);
          else fill(100, 100, 50);
          float xpStart = (resolutionWidth - (tw * tilesPerRow)) / 2;
          rect(t.x + xpStart, y + t.y, t.w, t.h);
          fill(30);
          textSize(t.th);
          float ty = y + t.y + t.th;
          text(t.op, t.x + (t.w / 2) - (t.tw / 2), ty);
        }
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
    int answer;
    float h = 24;
    float w;

    OOOQuestion(int difficulty) {
      final String[] symbols = {"+", "-", "*", "|", "&", "^"};
      switch(difficulty) {

      case 0:
        {
          String[] symbol1 = {"*", symbols[(int)random(2)]};
          List symbolList = Arrays.asList(symbol1);
          Collections.shuffle(symbolList);
          symbolList.toArray(symbol1);
          if ((int)random(2) == 0) {
            question = (int)random(1, 10) + " " + symbol1[0] + " " + (int)random(1, 10) + " " + symbol1[1] + " " + (int)random(1, 10);
          } else {
            question = (int)random(1, 10) + " " + symbol1[0] + " " + (int)random(1, 10) + " " + symbol1[1] + " " + (int)random(1, 10);
          }
          break;
        }
      case 1:
        {
          String[] symbol1 = {"*", "*", symbols[(int)random(2)], symbols[(int)random(2)]}; 
          List symbolList = Arrays.asList(symbol1);
          Collections.shuffle(symbolList);
          symbolList.toArray(symbol1);
          question = (int)random(1, 10) + " " + symbol1[0] + " " + (int)random(1, 10) + " " + symbol1[1] + " " + (int)random(1, 10) + " " + symbol1[2] + " " + (int)random(1, 10) + " " + symbol1[3] + " " + (int)random(1, 10);
          break;
        }
      case 2:
        {
          String[] symbol1 = {"*", "*", symbols[(int)random(2)], symbols[(int)random(2)]}; 
          List symbolList = Arrays.asList(symbol1);
          Collections.shuffle(symbolList);
          symbolList.toArray(symbol1);
          int r1 = (int)random(2);
          int r2 = (int)random(2);

          question = "";

          if (r1 == 0) {
            question += "(" + (int)random(1, 10) + " " + symbol1[0] + " " + (int)random(1, 10);
          } else {
            question += (int)random(1, 10) + " " + symbol1[0] + " (" + (int)random(1, 10);
          }
          if (r2 == 0) {
            question += " " + symbol1[1] + " " + (int)random(1, 10) + ") " + symbol1[2] + " " + (int)random(1, 10) + " " + symbol1[3] + " " + (int)random(1, 10);
          } else {
            question += " " + symbol1[1] + " " + (int)random(1, 10) + " " + symbol1[2] + " " + (int)random(1, 10) + ") " + symbol1[3] + " " + (int)random(1, 10);
          }
          break;
        }
      case 3:
        {
          String[] symbol1 = {symbols[(int)random(6)], symbols[(int)random(3, 6)], symbols[(int)random(3)], symbols[(int)random(3)]}; 
          List symbolList = Arrays.asList(symbol1);
          Collections.shuffle(symbolList);
          symbolList.toArray(symbol1);
          int r1 = (int)random(2);
          int r2 = (int)random(2);

          question = "";

          if (r1 == 0) {
            question += "(" + (int)random(1, 10) + " " + symbol1[0] + " " + (int)random(1, 10);
          } else {
            question += (int)random(1, 10) + " " + symbol1[0] + " (" + (int)random(1, 10);
          }
          if (r2 == 0) {
            question += " " + symbol1[1] + " " + (int)random(1, 10) + ") " + symbol1[2] + " " + (int)random(1, 10) + " " + symbol1[3] + " " + (int)random(1, 10);
          } else {
            question += " " + symbol1[1] + " " + (int)random(1, 10) + " " + symbol1[2] + " " + (int)random(1, 10) + ") " + symbol1[3] + " " + (int)random(1, 10);
          }
          break;
        }
      }
      try {
        Object o = functionEvaluator.eval(question);
        answer = (Integer)o;
      }
      catch(Exception e) {
        e.printStackTrace();
      }

      question += " = ?";        
      textFont(courier);
      textSize(h);
      w = textWidth(question);
      textFont(arial);
    }

    void setQuestionToDisplayAnswer() {
      question = question.substring(0, question.length() - 1) + answer;
      textFont(courier);
      textSize(h);
      w = textWidth(question);
      textFont(arial);
    }
  }

  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState1 = 2;
  final int tutorialState2 = 3;
  final int findStartState = 4;
  final int tileGameState = 5;
  final int fillInGameState = 6;
  final int cameraPanState = 7;
  final int playerTransitionState = 8;
  final int playerFallState = 9;
  final int fillInQuestionState = 10;
  final int findExitState = 11;

  final int TOTAL_OOB_STAGES = 4;

  float startPlayerX;
  float startPlayerY;
  float playerXDest;
  float playerYDest;

  float cameraPanSpeed = 10;

  int opDisplayYOffset;
  int currentSubStage;

  boolean uok;
  boolean dok;
  boolean lok;
  boolean rok;

  boolean tabOk = true;
  boolean displayOperatorsMode;

  boolean onFillInQuestion = true;
  boolean questionWrong = false;

  boolean skipTutorial;

  OOOLevel level;
  OOOLevel plevel;
  OperationTile currentTile;
  OperationTile previousTile;

  OOOBridge() {

    host = loadImage("bird.png");

    exitX = 500;
    exitY = 300;
    exitW = 50;
    exitH = 90;
    hostX = exitX + 200;
    hostY = exitY;
    player.x = exitX;
    player.y = exitY;
    camera.x = 0;
    camera.y = 0;
    background = new Background(resolutionWidth, resolutionHeight);
    background.clr = color(25, 100, 200);
    currentBackground = background;
  }

  boolean update() {
     background(background.clr);
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
        renderTextBox("To cross the bridge, you're going to need", 
          "to learn about Java's order of operations.");
        if (renderDialogChoice("What's that?")) {
          currentStageState = tutorialState1;
        }
        if (renderDialogChoice("I already know all about that.")) {
          currentStageState = findStartState;
          skipTutorial = true;
        }
        break;
      }
    case tutorialState1:
      {
        player.update();
        camera.update();
        renderTextBox("When evaluating a mathematical expression, Java will", 
          "perform certain operations ahead of others, regardless of where", 
          "they are in the expression. For example:", 
          "2 + 3 * 4", 
          "is equal to 14 and not 20. This is because", 
          "Java will do the multiplication before the addition.", 
          "You can press the TAB key at any time or click on the", 
          "\"View List\" button to bring up Java's", 
          "order of operations.");
        if (renderDialogChoice("Okay.")) {
          currentStageState = tutorialState2;
        }
        break;
      }
    case tutorialState2:
      {
        player.update();
        camera.update();
        renderTextBox("If you want to cross the bridge, you must walk across the", 
          "tiles with the operations on them in the same", 
          "order that they would be evaluated in a Java expression.", 
          "Then you must answer a mathematical question in the same way", 
          "that Java would. You must complete 4 sections to get to the", 
          "other side. Are", 
          "you clear on how to cross the bridge?");
        if (renderDialogChoice("Clear!")) {
          currentStageState = findStartState;
        }
        if (renderDialogChoice("Not really.")) {
          currentStageState = tutorialState1;
        }
        break;
      }
    case findStartState:
      {
        if (skipTutorial) {
          renderTextBox("Very well then. Walk up to begin.");
        } else if(currentSubStage == 0) {
          renderTextBox("Good! Walk to the top of the screen to begin.");
        }
        player.update();
        camera.update();
        if (player.y <= 0) {
          skipTutorial = false;
          if (currentSubStage < TOTAL_OOB_STAGES) {
            onFillInQuestion = false;
            level = new OOOLevel(onFillInQuestion, 0);
            level.y = -resolutionHeight;
            int cellx = (int)(player.x / level.tw);
            player.x = (cellx * level.tw) + ((level.tw / 2) - (player.w / 2));
            currentStageState = cameraPanState;
            background.h += resolutionHeight;
          } else {
            currentStageState = cameraPanState;
            background.h += resolutionHeight;
            exitY = -resolutionHeight / 2;
            level = null;
          }
        }  
        break;
      }
    case tileGameState:
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
          onFillInQuestion = true;
          level = new OOOLevel(onFillInQuestion, currentSubStage);
          level.y = -resolutionHeight;
        }  

        if (level != null) {
          level.render();
        }

        if (plevel != null) {
          plevel.render();
        }

        if (renderPlayerButton("Exit", 150, resolutionHeight - 60)) {
          ret = false;
          returnToWorld();
        }
        break;
      }
    case fillInGameState:
      {
        if (questionWrong) {
          player.update();
          if (renderPlayerButton("Retry", resolutionWidth / 2 - 150, resolutionHeight - 200)) {
            level.fillInQBoxColor = color(20, 20, 20, 200);
            questionWrong = false;
            inputBoxString = "";
            level.fillInQuestion = new OOOQuestion(currentSubStage);
          }
          if (renderPlayerButton("Exit", resolutionWidth / 2 + 150, resolutionHeight - 200)) {
            ret = false;
            returnToWorld();
          }
        } else {
          float w = 150;
          String ans = renderInputBox((int)w);
          if (ans != null) {
            double d = Double.MIN_VALUE;
            try {
              d = Double.parseDouble(ans);
            }
            catch(Exception e) {
            }
            if (Math.abs(d - level.fillInQuestion.answer) >= 0.01) {
              questionWrong = true;
              level.fillInQBoxColor = color(200, 20, 20, 200);
              level.fillInQuestion.setQuestionToDisplayAnswer();
            } else {
              currentSubStage++;
              currentStageState = findStartState;
            }
          }
        }
        camera.update();
        if (level != null) {
          level.render();
        }

        break;
      }
    case cameraPanState:
      {
        camera.y -= cameraPanSpeed;

        if (level != null) {
          level.y += cameraPanSpeed;
          level.render();
        } 

        if (player.y + player.h < resolutionHeight) {
          player.y += cameraPanSpeed;
        }
        if (camera.y <= -resolutionHeight) {
          exitY += resolutionHeight;
          hostY += resolutionHeight;
          if (onFillInQuestion) {
            if (currentSubStage < TOTAL_OOB_STAGES) {
              currentStageState = fillInGameState;
              player.y = resolutionHeight - player.h - 150;
            } else {
              currentStageState = findExitState;
            }
            inputBoxString = "";
          } else {
            currentStageState = tileGameState; 

            player.y = ((int)(player.y / level.tw) * level.tw) + ((level.tw / 2) - (player.h / 2));

            startPlayerX = player.x;
            startPlayerY = player.y;
          }
          background.h = resolutionHeight;
          camera.y = 0;
          if (level != null) level.y = 0;
          plevel = null;
        }

        if (plevel != null) {
          plevel.y += cameraPanSpeed;
          plevel.render();
        }
        break;
      }
    case playerTransitionState:
      {
        float s = 10;
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
                if (currentTile.group < previousTile.group) {
                  currentStageState = playerFallState;
                }
              }
            }
          }
          if (currentStageState != playerFallState) {
            currentStageState = tileGameState;
          }
        }
        if (renderPlayerButton("Exit", 150, resolutionHeight - 60)) {
          ret = false;
          returnToWorld();
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

        if (player.w > 0.001 && player.h > 0.001) {
          player.w *= fallSpeed;
          player.h *= fallSpeed;
          player.x = tx + (level.tw / 2) - (player.w / 2);
          player.y = ty + (level.tw / 2) - (player.h / 2);
        } else {
          level = new OOOLevel(onFillInQuestion, 0);
          player.x = startPlayerX;
          player.y = startPlayerY;
          player.w = player.image.width;
          player.h = player.image.height;
          currentStageState = tileGameState;
        }

        level.render();
        break;
      }
    case findExitState:
      {
        player.update();
        camera.update();
        //fill(200);
        //rect(exitX, exitY, exitW, exitH);
        break;
      }
    }

    if (checkForExit() && checkInteraction()) {
      if (currentSubStage == TOTAL_OOB_STAGES) {
        completed = true;
      }
      returnToWorld();
      ret = false;
    }
    image(player.image, player.x, player.y, player.w, player.h);

    if (displayOperatorsMode) {
      opDisplayYOffset -= scrollAmount * 20;

      if (keyPressed && keyCode == DOWN) {
        opDisplayYOffset -= 10;
      }
      if (keyPressed && keyCode == UP) {
        opDisplayYOffset += 10;
      }

      if (opDisplayYOffset > 0) {
        opDisplayYOffset = 0;
      } else if (opDisplayYOffset < -resolutionHeight) {
        opDisplayYOffset = -resolutionHeight;
      }
      fill(0, 0, 0, 200);
      float margin = 25;
      float mx2 = margin * 2;
      float idt1 = margin * 8;
      float idt2 = margin * 18;
      float bw = resolutionWidth - mx2;
      float bb = resolutionHeight * 2 - 200;
      float br = margin + bw;
      strokeWeight(10);
      rect(margin, margin + opDisplayYOffset, bw, bb, 20);
      strokeWeight(5);
      line(idt1, margin + opDisplayYOffset, idt1, bb + margin + opDisplayYOffset);
      line(idt2, margin + opDisplayYOffset, idt2, bb + margin + opDisplayYOffset);
      line(margin, 80 + opDisplayYOffset, br, 80 + opDisplayYOffset);
      strokeWeight(1);

      textFont(arial);
      fill(255);
      textSize(25);
      centeredText("Precedence", margin, idt1, 60 + opDisplayYOffset);
      centeredText("Group", idt1, idt2, 60 + opDisplayYOffset);
      centeredText("Operators in Order", idt2, br, 60 + opDisplayYOffset);
      for (int i = 1; i < totalOperationGroups + 1; i++) {
        centeredText("" + i, margin, idt1, 60 + opDisplayYOffset + (i * 60));
        centeredText(OPERATION_TYPES[i - 1], idt1, idt2, 60 + opDisplayYOffset + (i * 60));
      }
      textFont(courier);
      textSize(16);
      for (int i = 0; i < totalOperationGroups; i++) {
        String ops = "";
        for (int j = 0; j < OPERATIONS[i].length; j++) {
          ops += OPERATIONS[i][j];
          if (j < OPERATIONS[i].length - 1) {
            ops += ", ";
          }
        }
        centeredText(ops, idt2, br, 60 + opDisplayYOffset + ((i + 1) * 60));
      }
      textFont(arial);
      if (renderDialogChoice("Close List", resolutionWidth - 150, resolutionHeight - 50, color(255, 0, 0), color(255))) {
        displayOperatorsMode = !displayOperatorsMode;
      }
    } else {
      if (renderDialogChoice("View List", resolutionWidth - 150, resolutionHeight - 50, color(255, 0, 0), color(255))) {
        displayOperatorsMode = !displayOperatorsMode;
      }
    }



    return ret;
  }
}
