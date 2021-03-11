class ImportsShack extends Stage {
  class CodeLine extends PushBox {


    final static float size = 24;
    final color boxColor = color(0, 0, 64);
    final color textColor = color(255, 196, 196);

    final static int COMMENT_LINE = 0;
    final static int PACKAGE_LINE = 1;
    final static int IMPORT_LINE = 2;
    final static int PUBLIC_CLASS_LINE = 3;
    final static int CLASS_LINE = 4;
    final static int METHOD_LINE = 5;
    final static int VAR_CREATE_LINE = 6;
    final static int totalCodeLineTypes = 7;

    String text;
    int type;

    CodeLine(float x, float y, int type) {
      this.type = type;
      switch(type) {
      case COMMENT_LINE:
        {
          String c = COMMENTS[(int)random(COMMENTS.length)];
          if ((int)random(2) == 0) {
            text = "//" + c;
          } else {
            text = "/*" + c + "*/";
          }
          break;
        }
      case PACKAGE_LINE:
        {
          text = "package " + WORD_LIST[(int)random(WORD_LIST.length)] + ";";
          break;
        }
      case IMPORT_LINE:
        {
          text = "import " + WILDCARD_IMPORTS[(int)random(WILDCARD_IMPORTS.length)] + ";";
          break;
        }
      case PUBLIC_CLASS_LINE:
        {
          String cn = WORD_LIST[(int)random(WORD_LIST.length)];
          cn = Character.toUpperCase(cn.charAt(0)) + cn.substring(1);
          text = "public class " + cn + "{";
          break;
        }
      case CLASS_LINE:
        {
          String cn = WORD_LIST[(int)random(WORD_LIST.length)];
          cn = Character.toUpperCase(cn.charAt(0)) + cn.substring(1);
          text = "class " + cn + "{";
          break;
        }
      case METHOD_LINE:
        {
          text = "public void " + WORD_LIST[(int)random(WORD_LIST.length)] + "(){";
          break;
        }
      case VAR_CREATE_LINE:
        {
          text = JAVA_DATA_TYPES[(int)random(JAVA_DATA_TYPES.length)] + " " + WORD_LIST[(int)random(WORD_LIST.length)] + ";";
          break;
        }
      }

      textFont(courier);
      this.x = x;
      this.y = y;
      textSize(size);
      this.w = textWidth(text);
      this.h = size;
      textFont(arial);
    }

    void render() {
      textFont(courier);
      textSize(size);
      fill(boxColor);
      rect(x - camera.x, y - camera.y, w, h);
      fill(textColor);
      text(text, x - camera.x, y - camera.y + h - 4);
      textFont(arial);
    }
  }

  class Level {
    ArrayList<CodeLine> code = new ArrayList<CodeLine>();
    float[] codeXPositions;
    float[] codeYPositions;

    Level() {
      for (int i = 1; i < CodeLine.totalCodeLineTypes; i++) {
        if ((int)random(CodeLine.totalCodeLineTypes) == 0) {
          code.add(new CodeLine(0, 0, CodeLine.COMMENT_LINE));
        }
        code.add(new CodeLine(0, 0, i));
      }

      codeXPositions = new float[code.size()];
      codeYPositions = new float[code.size()];

      for (int i = 0; i < code.size(); i++) {
        CodeLine c = code.get(i);
        codeXPositions[i] = c.x;
        codeYPositions[i] = c.y;
      }

      int[] pickedRand = new int[code.size()];
      int totalRandomized = 0;
      while (totalRandomized < code.size()) {
        int r = (int)random(code.size());
        boolean picked = false;
        for (int i = 0; i < totalRandomized; i++) {
          if (r == pickedRand[i]) {
            picked = true;
            break;
          }
        }
        if (!picked) {
          pickedRand[totalRandomized] = r;
          totalRandomized++;
        }
      }

      float cx = random(100, 300);
      float cy = 100;
      for (int i = 0; i < pickedRand.length; i++) {
        CodeLine cl = code.get(pickedRand[i]);
        if (cx + cl.w + 100 > resolutionWidth) {
          cx = random(100, 300);
          cy += random(100, 150);
        }
        codeXPositions[i] = cx;
        codeYPositions[i] = cy;
        cl.x = codeXPositions[i]; 
        cl.y = codeYPositions[i];

        cx += cl.w + 100;
      }
    }

    void resetLevel() {
      for (int i = 0; i < code.size(); i++) {
        CodeLine c = code.get(i);
        c.x = codeXPositions[i];
        c.y = codeYPositions[i];
      }
    }

    boolean checkForWin() {
      boolean ret = true;

      for (int i = 0; i < code.size() - 1; i++) {
        CodeLine c1 = code.get(i);
        if (c1.type == 0) continue;
        for (int j = i + 1; j < code.size(); j++) {
          CodeLine c2 = code.get(j);
          if (c2.type == 0) continue;
          if (c2.type > c1.type && c2.y > c1.y) continue;
          else if (c2.type == c1.type) continue;
          else {
            ret = false;
            i = code.size();
            break;
          }
        }
      }

      return ret;
    }
  }

  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int tutorialState2 = 3;
  final int tutorialState3 = 4;
  final int doorSearchState = 5;
  final int packageGameState1 = 6;

  int currentLevel = 0;
  boolean skipTutorial;
  boolean stageComplete;
  boolean incorrectAnswer;

  Background gameBackground = new Background(resolutionWidth, resolutionHeight * 2);
  Level level;

  ImportsShack() {
    x = 400;
    y = 750;
    exitX = 100;
    exitY = 100;
    player.x = exitX;
    player.y = exitY;
    camera.x = 0;
    camera.y = 0;
    exitW = 50;
    exitH = 90;
    hostX = exitX + 200;
    hostY = exitY;
    host = loadImage("sloth.png");

    background = new Background(resolutionWidth, resolutionHeight);
    background.clr = color(153, 93, 3);
    currentBackground = background;
  }

  boolean update() {
    background(background.clr);
      player.update();
      camera.update();
      
      
    
    boolean ret = true;

    float cx = hostX - camera.x;
    float cy = hostY - camera.y;
    fill(200);
    if (currentStageState < packageGameState1) {
      image(host, cx, cy, host.width, host.height);
      rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);
    }

    switch(currentStageState) {
    case searchState:
      {
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Sloth", cx, cy); 
          if (checkInteraction()) {

            currentStageState = greetingState;
          }
        }
        break;
      }
    case greetingState:
      {
        renderTextBox("Listen up because I'm going to talk fast.");
        if (renderDialogChoice("Okay. I'm listening.")) {
          currentStageState = tutorialState;
        } else if (renderDialogChoice("I already know what you're going to say.")) {
          currentStageState = doorSearchState;
          skipTutorial = true;
        }
        break;
      }
    case tutorialState:
      {
        renderTextBox("Java code has to go in order.", 
          "Package declarations always come first.", 
          "Import statements must come next, if there are any.", 
          "After import statements come class declarations.", 
          "There can be only one public class per java file.", 
          "Comments can go anywhere.");
        if (renderDialogChoice("Uh huh.")) {
          currentStageState = tutorialState2;
        }

        break;
      }
    case tutorialState2:
      {
        renderTextBox("All method declarations must be written inside of a class.", 
          "Variables can be created and initialized inside or", 
          "outside of a method, but any calls to a method,", 
          "but it must be done inside of a class. Any calls to", 
          "a method must be done from inside a method.");
        if (renderDialogChoice("I'm with you so far.")) {
          currentStageState = tutorialState3;
        }
        if (renderDialogChoice("Wait. I'm confused.")) {
          currentStageState = tutorialState;
        }

        break;
      }
    case tutorialState3:
      {
        renderTextBox("Go through the door to the right to start.", 
          "Put the code in the correct order from top to bottom.", 
          "Got it?");
        if (renderDialogChoice("Got it.")) {
          currentStageState = doorSearchState;
        }
        if (renderDialogChoice("No.")) {
          currentStageState = tutorialState;
        }

        break;
      }

    case doorSearchState:
      {
        fill(128, 40, 75);
        float dx = hostX + 400 - camera.x;
        float dy = hostY + 200 - camera.y;
        float dw = 50;
        float dh = 100;
        rect(dx, dy, dw, dh, 18, 18, 0, 0);

        if (checkIntersection(player.x, player.y, player.w, player.h, dx, dy, dw, dh)) {
          textSize(promptTextSize);
          fill(255);
          text("Press SPACE to Begin Sorting Packages", dx, dy);
          if (checkInteraction()) {
            currentStageState = packageGameState1;
            currentBackground = gameBackground;
            level = new Level();
          }
        }
        if (skipTutorial) {
          renderTextBox("Oh! Um. Okay. Well, you better get to it then.");
        }
        break;
      }
    case packageGameState1:
      {
        background(background.clr);
        if (stageComplete) {

          rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);
          if (checkForExit()) {
            if (checkInteraction()) {
              if (currentLevel < 6) {
                level = new Level();
                stageComplete = false;
                currentLevel++;
              } else {
                stageComplete = false; 
                currentBackground = worldMapBackground;
                currentState = GameStates.WORLD_MAP_STATE;
                return false;
              }
            }
          }
          for (CodeLine c : level.code) {
            c.render();
          }
          if (currentLevel > 5) {
            renderTextBox("You did it!", "Move to the exit for the next stage.");
          }
        } else {

          if (renderPlayerButton("SUBMIT", 100, 700)) {
            if (level.checkForWin()) {
              exitX = 300;
              exitY = 800;
              stageComplete = true;
              incorrectAnswer = false;
              completed = true;
            } else {
              incorrectAnswer = true;
            }
          }
          if (renderPlayerButton("RESET", 500, 700)) {
            level.resetLevel();
            incorrectAnswer = false;
          }
          if (renderPlayerButton("EXIT", 200, 900)) {
            returnToWorld();
            ret = false;
          }

          for (CodeLine c : level.code) {
            handlePushBoxCollision(c);
            c.render();
          }

          if (incorrectAnswer) {
            renderTextBox("Not quite. Try again.");
          }
        }

        break;
      }
    }
    if (currentStageState < packageGameState1 && checkForExit()) {
      if (checkInteraction()) {
        returnToWorld();
        ret = false;
      }
    }
    image(player.image, player.x, player.y, player.w, player.h);
    return ret;
  }
}
