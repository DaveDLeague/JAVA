class VariablesCave extends Stage {
  class Variable {
    String name;
    float x;
    float y;
    float w;
    float h;
    boolean valid;

    Variable(float x, float y) {
      textFont(courier);
      this.x = x;
      this.y = y;
      this.h = 24;

      this.valid = (int)random(2) == 0 ? true : false;
      if (valid) {
        final int plainOp = 0;
        final int cap1stOp = 1;
        final int capRandOp = 2;
        final int addNumOp = 3;
        final int ranNumOp = 4;
        final int _InFrontOp = 5;
        final int rand_Op = 6;
        final int $InFrontOp = 7;
        final int rand$Op = 8;
        final int letToNumOp = 9;
        final int totalOps = 10;
        final int op = (int)random(totalOps);
        this.name = WORD_LIST[(int)random(WORD_LIST.length)];
        switch(op) {
        case plainOp:
          {
            break;
          }
        case cap1stOp:
          {
            name = Character.toUpperCase(name.charAt(0)) + name.substring(1, name.length());
            break;
          }
        case capRandOp:
          {
            String n = "" + name.charAt(0);
            for (int i = 1; i < name.length(); i++) {
              boolean b = (int)random(2) == 0 ? true : false;
              if (b) {
                n += Character.toUpperCase(name.charAt(i));
              } else {
                n += name.charAt(i);
              }
            }
            name = n;
            break;
          }
        case addNumOp:
          {
            name += generateRandomNumberString(4);
            break;
          }
        case ranNumOp:
          {
            String n = "" + name.charAt(0);
            for (int i = 1; i < name.length(); i++) {
              boolean b = (int)random(4) == 0 ? true : false;
              if (b) {
                n += name.charAt(i) + generateRandomNumberString(4);
              } else {
                n += name.charAt(i);
              }
            }
            name = n;
            break;
          }
        case _InFrontOp:
          {
            name = "_" + name;
            break;
          }
        case rand_Op:
          {
            String n = "" + name.charAt(0);
            for (int i = 1; i < name.length(); i++) {
              boolean b = (int)random(2) == 0 ? true : false;
              if (b) {
                n += "_" + name.charAt(i);
              } else {
                n += name.charAt(i);
              }
            }
            name = n;
            break;
          }
        case $InFrontOp:
          {
            char c = CURRENCY_SYMBOLS[(int)random(CURRENCY_SYMBOLS.length)];
            boolean b = (int)random(2) == 0 ? true : false;
            if (b) {
              boolean found = false;
              while (!found) {
                String s = WORD_LIST[(int)random(WORD_LIST.length)];
                char ch = s.charAt(0);
                if (ch == 'e') {
                  name = '€' + s.substring(1, s.length());
                  found = true;
                } else if (ch == 'l') {
                  name = '£' + s.substring(1, s.length());
                  found = true;
                } else if (ch == 's') {
                  name = '$' + s.substring(1, s.length());
                  found = true;
                } else if (ch == 'y') {
                  name = '¥' + s.substring(1, s.length());
                  found = true;
                } else if (ch == 'c') {
                  name = '¢' + s.substring(1, s.length());
                  found = true;
                }
              }
            } else {
              name = c + name;
            }
            break;
          }
        case rand$Op:
          {
            String n = "" + name.charAt(0);
            for (int i = 1; i < name.length(); i++) {
              boolean b = (int)random(2) == 0 ? true : false;
              if (b) {
                char c = CURRENCY_SYMBOLS[(int)random(CURRENCY_SYMBOLS.length)];
                n += "" + (char)c + (char)name.charAt(i);
              } else {
                n += name.charAt(i);
              }
            }
            name = n;
            break;
          }
        case letToNumOp:
          {
            String n = "" + name.charAt(0);
            for (int i = 1; i < name.length(); i++) {
              char c = name.charAt(i);
              if (c == 'l') {
                n += '1';
              } else if (c == 'o') {
                n += '0';
              } else if (c == 'e') {
                n += '3';
              } else if (c == 'z') {
                n += '2';
              } else if (c == 's') {
                n += '5';
              } else {
                n += c;
              }
            }
            name = n;
            break;
          }
        }
      } else {
        final int numInFrontOp = 0;
        final int justNumOp = 1;
        final int keywordOp = 2;
        final int badCharOp = 3;
        final int hasSpaceOp = 4;
        final int totalOps = 5;
        int op = (int)random(totalOps);
        switch(op) {
        case numInFrontOp:
          {
            name = generateRandomNumberString(4) + WORD_LIST[(int)random(WORD_LIST.length)];
            break;
          }
        case justNumOp:
          {
            name = generateRandomNumberString(9);
            break;
          }
        case keywordOp:
          {
            name = JAVA_KEYWORDS[(int)random(JAVA_KEYWORDS.length)];
            break;
          }
        case badCharOp:
          {
            char[] badChars = {
              '!', '~', '@', '#', '%', '^', '&', '*', '-', '+', '?', '<', '>', '(', ')', '=', '.', ',', ';', ':', 
            }; 

            String wd = WORD_LIST[(int)random(WORD_LIST.length)];

            final int inParen = 0;
            final int inAngle = 1;
            final int inBrack = 2;
            final int questMark = 3;
            final int charInside = 4;
            final int tot = 5;
            int o = (int)random(tot);
            if (o == inParen) {
              name = '(' + wd + ')';
            } else if (o == inAngle) {
              name = '<' + wd + '>';
            } else if (o == inBrack) {
              name = '[' + wd + ']';
            } else if (o == questMark) {
              name = wd + '?';
            } else if (o == charInside) {
              int r = (int)random(1, wd.length());
              name = wd.substring(0, r) + badChars[(int)random(badChars.length)] + wd.substring(r, wd.length());
            }
          }
        case hasSpaceOp:
          {
            String wd = WORD_LIST[(int)random(WORD_LIST.length)];
            int r = (int)random(1, wd.length());
            name = wd.substring(0, r) + ' ' + wd.substring(r, wd.length());
            break;
          }
        }
      }

      textSize(this.h);
      this.w = textWidth(name);
      textFont(arial);
    }
  }
  ArrayList<Variable> variables = new ArrayList<Variable>();
  ArrayList<Variable> collectedVariables = new ArrayList<Variable>();
  ArrayList<String> wrongVariables = new ArrayList<String>();
  ArrayList<String> missedVariables = new ArrayList<String>();

  color variableColor;

  final int searchState = 0;
  final int greetingState = 1;
  final int inquireState = 2;
  final int gatherState = 3;
  final int checkState = 4;

  int totalValid; 

  boolean collected = false;

  VariablesCave(StageImage image) {
    super(image);

    x = 1200;
    y = 350;
    hostX = 500;
    hostY = 500;
    exitX = image.x - camera.x;
    exitY = image.y - camera.y;
    exitW = 50;
    exitH = 90;
    w = image.image.width;
    h = image.image.height;
    state = GameStates.VARIABLES_CAVE_STATE;

    host = loadImage("octopus.png");

    variableColor = color(200, 200, 255);

    background = new Background(resolutionWidth, resolutionHeight * 2);
    background.clr = color(0);
    currentBackground = background;

    randomizeVariables();
  }

  void randomizeVariables() {
    collectedVariables.clear();
    variables.clear();

    boolean va = false;
    totalValid = 0;
    final float bf = 100;
    float vx = bf;
    float vy = bf;
    while (!va) {
      Variable v = new Variable(vx, vy);
      vx += v.w + bf;

      if (checkIntersection(v.x - bf, v.y - bf, v.w + bf, v.h + bf, hostX, hostY - 100, host.width, host.height)) {
        vy += v.h + bf; 
        vx = bf;
        continue;
      }
      if (checkIntersection(v.x - bf, v.y - bf, v.w + bf, v.h + bf, exitX, exitY, exitW, exitH)) {
        continue;
      }

      if (vx + v.w + bf >= resolutionWidth) {
        vx = bf;
        vy += v.h + bf; 
        if (vy + v.h + bf >= background.h) {
          va = true;
          break;
        }
      }
      if (v.valid) totalValid++;
      variables.add(v);
    }
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
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Octopus", cx, cy); 
          if (checkInteraction()) {
            currentStageState = greetingState;
          }
        }
        break;
      }
    case greetingState:
      {
        renderTextBox("Bring me all of the names that can be used", 
          "to name a variable, object, method, or class", 
          "in Java.");
        if (renderDialogChoice("Okay!")) {
          currentStageState = gatherState;
        }
        if (renderDialogChoice("How do I know which ones are those?")) {
          currentStageState = inquireState;
        }
        break;
      }
    case inquireState:
      {
        renderTextBox("The names can only consist of numbers, letters, underscores,", 
          "and currency symbols. They absolutely cannot begin with a number!", 
          "They cannot have spaces and cannot have the same name as a reserved Java keyword.");
        if (renderDialogChoice("Okay!")) {
          currentStageState = gatherState;
        }
        break;
      }
    case gatherState:
      {
        updateVariables();
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to give the variables to the Octopus", cx, cy); 
          if (checkInteraction()) {
            if (checkForAllCollectedVariables()) {
              collected = true;
            } else {
              collected = false;
            }
            currentStageState = checkState;
          }
        }

        if (renderPlayerButton("RESET", hostX + host.width + 100, hostY + 50)) {
          while (collectedVariables.size() > 0) {
            Variable v = collectedVariables.get(0);
            variables.add(v);
            collectedVariables.remove(0);
          }
        }
        break;
      }
    case checkState:
      {
        updateVariables(false);
        if (collected) {
          renderTextBox("Great! You got them all!", "Now leave me alone with my variables!"); 
          image.completed = true;
        } else {
          if (renderPlayerButton("TRY AGAIN", hostX + host.width + 100, hostY + 50)) {
            randomizeVariables();
            currentStageState = gatherState;
          }
          String[] wv = new String[wrongVariables.size()];
          wv = wrongVariables.toArray(wv);
          String[] mv = new String[missedVariables.size()];
          mv = missedVariables.toArray(mv);
          if (missedVariables.size() == 0 && wrongVariables.size() > 0) {
            renderTextBox(20, "What is this? You trying to give me bad variables?", 
              "These are no good:");
            renderTextBox(105, color(100, 100, 100, 196), color(255, 100, 100), wv);
          } else if (missedVariables.size() > 0 && wrongVariables.size() == 0) {
            renderTextBox(50, "You missed some.");
            renderTextBox(130, color(100, 100, 100, 196), color(200, 255, 200), mv);
          } else {
            renderTextBox(100f, 50f, "These are no good:");
            renderTextBox(135, 130, color(100, 100, 100, 196), color(255, 100, 100), wv);
            renderTextBox(600f, 50f, "These ones you missed:");
            renderTextBox(635, 130, color(100, 100, 100, 196), color(100, 255, 100), mv);
          }
          
        }
        break;
      }
    }


    if (checkForExit()) {
      if (checkInteraction()){
        currentState = GameStates.WORLD_MAP_STATE;
        currentBackground = worldMapBackground;
        camera.x = 0;
        camera.y = 0;
        player.x = image.x - camera.x;
        player.y = image.y - camera.y;


        ret = false;
      }
    }
    return ret;
  }

  public void render() {
  }

  void updateVariables() {
    updateVariables(true);
  }
  void updateVariables(boolean intersection) {
    textFont(courier);

    for (int i = 0; i < variables.size(); i++) {
      Variable v = variables.get(i);
      textSize(v.h);
      float nx = v.x - camera.x;
      float ny = v.y - camera.y;
      fill(75, 75, 75, 200);
      rect(nx - 5, ny - v.h, v.w + 10, v.h * 2, 3);
      fill(variableColor);
      text(v.name, nx, ny);

      if (intersection && checkIntersection(player.x, player.y, player.w, player.h, nx, ny, v.w, v.h)) {
        textFont(arial);
        textSize(promptTextSize);
        fill(255);
        text("Press SPACE to collect variable", nx, ny - 20);   
        textFont(courier);

        if (checkInteraction()) {
          variables.remove(v); 
          collectedVariables.add(v);
        }
      }
    }
    textFont(arial);
  }

  boolean checkForAllCollectedVariables() {
    boolean ret = true;
    wrongVariables.clear();
    missedVariables.clear();

    if (collectedVariables.size() != totalValid) {
      for (Variable v : variables) {
        if (v.valid) {
          for (Variable cv : collectedVariables) {
            if (!v.name.equals(cv)) {
              missedVariables.add(v.name);
              break;
            }
          }
        }
      }
      ret = false;
    }
    for (Variable v : collectedVariables) {
      if (!v.valid) {
        wrongVariables.add(v.name);
        ret = false;
      }
    }
    return ret;
  }
}
