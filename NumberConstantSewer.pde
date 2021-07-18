class NumberConstantSewer extends Stage { //<>// //<>//
  class NumberConstant {
    String value;
    float x;
    float y;
    float w;
    float h;
    boolean valid;

    NumberConstant(float x, float y) {
      textFont(courier);
      this.x = x;
      this.y = y;
      h = 24;
      valid = random(2) < 1 ? true : false;
      if (valid) {
        final int integer = 0;
        final int decimalD = 1;
        final int decimalF = 2;
        final int hex = 3;
        final int binary = 4;
        final int longCast = 5;
        final int signed = 6;
        final int underscores = 7;
        final int total = 8;
        int v = (int)random(total);
        switch(v) {
        case integer:
          {
            value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(8);
            break;
          }
        case decimalD:
          {
            value = "double " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5) + "." + generateRandomNumberString(4);
            if (random(3) < 1) {
              value +=  (random(2) < 1 ? "d" : "D");
            } else if (random(3) < 1) {
              value +=  (random(2) < 1 ? "f" : "F");
            }
            break;
          }
        case decimalF:
          {
            value = "float " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5) + "." + generateRandomNumberString(4) + (random(2) < 1 ? "f" : "F");
            break;
          }
        case hex:
          {
            value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + (random(2) < 1 ? "0x" : "0X") + generateRandomHexString(5);
            break;
          }
        case binary:
          {
            value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + (random(2) < 1 ? "0b" : "0B");
            int d = (int)random(1, 7);
            for (int i = 0; i < d; i++) {
              value += random(2) < 1 ? '0' : '1';
            }
            break;
          }
        case longCast:
          {
            value = "long " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(12) + (random(2) < 1 ? "l" : "L");
            break;
          }
        case signed:
          {
            value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + (random(2) < 1 ? "-" : "+") + generateRandomNumberString(8);
            break;
          }
        case underscores:
          {
            String nv = generateRandomNumberString(8);
            for (int i = 1; i < nv.length() - 1; i++) {
              if (random(3) < 1) {
                nv = nv.substring(0, i) + "_" + nv.substring(i, nv.length());
              }
            }
            value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + nv;

            break;
          }
        }
      } else {
        final int badCast = 0;
        final int badUnderscore = 1;
        final int badPrefix = 2;
        final int nonCast = 3;
        final int badBinary = 4;
        final int badHex = 5;
        final int total = 6;
        int v = (int)random(total);
        switch(v) {
        case badCast:
          {
            int rc = (int)random(7);
            if (rc == 0) {
              value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(8) + (random(2) < 1 ? "l" : "L");
            } else if (rc == 1) {
              value = "float " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5) + "." + generateRandomNumberString(4);
            } else if (rc == 2) {
              value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5) + "." + generateRandomNumberString(4);
            } else if (rc == 3) {
              value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5) + (random(2) < 1 ? "f" : "F");
            } else if (rc == 4) {
              value = "float " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5) + "." + generateRandomNumberString(4) + (random(2) < 1 ? "d" : "D");
            } else if (rc == 5) {
              if (random(2) < 1) {
                value = "long " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5) + "." + generateRandomNumberString(4) + (random(2) < 1 ? "d" : "D");
              } else {
                value = "long " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5) + "." + generateRandomNumberString(4) + (random(2) < 1 ? "f" : "F");
              }
            } else if (rc == 6) {
              if (random(2) < 1) {
                value = "long " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5)  + (random(2) < 1 ? "d" : "D");
              } else {
                value = "long " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5)  + (random(2) < 1 ? "f" : "F");
              }
            }
            break;
          }
        case badUnderscore:
          {
            int rc = (int)random(6);
            if (rc == 0) {
              value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = _" + generateRandomNumberString(8);
            } else if (rc == 1) {
              value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(8) + "_";
            } else if (rc == 2) {
              value = "float " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(8) + "_." + generateRandomNumberString(4) + (random(2) < 1 ? "f" : "F");
            } else if (rc == 3) {
              value = "float " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(8) + "._" + generateRandomNumberString(4) + (random(2) < 1 ? "f" : "F");
            } else if (rc == 4) {
              value = "float " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(8) + "._" + generateRandomNumberString(4) + (random(2) < 1 ? "f" : "F");
            } else {
              value = "double " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(8) + "." + generateRandomNumberString(4);
              int strt = 0;
              for (int i = 0; i < value.length(); i++) {
                if (Character.isDigit(value.charAt(i))) {
                  strt = i;
                  break;
                }
              }
              for (int i = strt; i < value.length(); i++) {
                if (random(3) < 1) {
                  value = value.substring(0, i) + "_" + value.substring(i, value.length());
                }
              }
              int rv = (int)random(4);
              if (rv == 0) {
                value = value.substring(0, strt) + "_" + value.substring(strt, value.length());
              } else if (rv == 1) {
                value += "_";
              } else if (rv == 2) {
                int ii = value.indexOf('.');
                value = value.substring(0, ii) + "_." + value.substring(ii + 1, value.length());
              } else if (rv == 3) {
                int ii = value.indexOf('.');
                value = value.substring(0, ii) + "._" + value.substring(ii + 1, value.length());
              }
            }

            break;
          }
        case badPrefix:
          {
            String[] bv = {"0z", "!", "%"};
            if (random(2) < 1) {
              value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + bv[(int)random(bv.length)] + generateRandomNumberString(8);
            } else {
              value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(8)+ bv[(int)random(bv.length)];
            }
            break;
          }
        case nonCast:
          {
            int rv = (int)random(3);
            if (rv == 0) {
              value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(8) + (random(2) < 1 ? 'i' : 'I');
            } else if (rv == 1) {
              value = "short " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(5) + (random(2) < 1 ? 's' : 'S');
            } else if (rv == 2) {
              value = "byte " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + generateRandomNumberString(3) + (random(2) < 1 ? 'b' : 'B');
            }
            break;
          }
        case badBinary:
          {
            int d = (int)random(2, 7);
            String nm = "";
            for (int i = 0; i < d; i++) {
              nm += random(2) < 1 ? '0' : '1'; 
            }
            int rnv = (int)random(nm.length());
            nm = nm.substring(0, rnv) + ((char)random('2', '9')) + nm.substring(rnv, nm.length());
            value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + (random(2) < 1 ? "0b" : "0B") + nm;
            break;
          }
        case badHex:
          {
            String hv = generateRandomHexString(2, 6);
            int d = (int)random(2, hv.length());
            hv = hv.substring(0, d) + (char)((int)random('G', 'Z')) + hv.substring(d, hv.length());
            value = "int " + WORD_LIST[(int)random(WORD_LIST.length)] + " = " + (random(2) < 1 ? "0x" : "0X") + hv;
            break;
          }
        }
      }
      value += ";";
      textSize(this.h);
      this.w = textWidth(value);
      textFont(arial);
    }
  }
  ArrayList<NumberConstant> constants = new ArrayList<NumberConstant>();
  ArrayList<NumberConstant> collectedConstants = new ArrayList<NumberConstant>();
  ArrayList<String> wrongConstants = new ArrayList<String>();
  ArrayList<String> missedConstants = new ArrayList<String>();

  color variableColor;

  final int searchState = 0;
  final int greetingState = 1;
  final int inquireState = 2;
  final int explainConstantState = 3;
  final int explainByteState = 4;
  final int explainShortState = 5;
  final int explainIntState = 6;
  final int explainLongState = 7;
  final int explainFloatState = 8;
  final int explainDoubleState = 9;
  final int gatherState = 10;
  final int checkState = 11;

  int totalValid; 

  boolean collected = false;
  NumberConstantSewer() {

    x = 1200;
    y = 350;
    hostX = 100;
    hostY = 500;
    exitX = 400;
    exitY = 300;
    exitW = 100;
    exitH = 60;

    player.x = exitX;
    player.y = exitY;

    host = loadImage("octopus2.png");

    variableColor = color(200, 200, 255);

    background = new Background(resolutionWidth * 2, resolutionHeight * 2);
    background.clr = color(0);
    currentBackground = background;

    randomizeVariables();
  }

  void randomizeVariables() {
    collectedConstants.clear();
    constants.clear();

    boolean va = false;
    totalValid = 0;
    final float bf = 100;
    float vx = bf;
    float vy = bf;
    while (!va) {
      NumberConstant v = new NumberConstant(vx, vy);
      vx += v.w + bf;

      if (checkIntersection(v.x - bf, v.y - bf, v.w + bf, v.h + bf, hostX, hostY - 100, host.width, host.height)) {
        vy += v.h + bf; 
        vx = bf;
        continue;
      }
      if (checkIntersection(v.x - bf, v.y - bf, v.w + bf, v.h + bf, exitX, exitY, exitW, exitH)) {
        continue;
      }

      if (vx + v.w + bf >= background.w) {
        vx = bf;
        vy += v.h + bf; 
        if (vy + v.h + bf >= background.h) {
          va = true;
          break;
        }
      }
      if (v.valid) totalValid++;
      constants.add(v);
    }
  }

  boolean update() {
    background(background.clr);
    player.update();
    camera.update();

    boolean ret = true;

    float cx = hostX - camera.x;
    float cy = hostY - camera.y;
    fill(#B5F6FC);
    ellipse(exitX - camera.x, exitY - camera.y, exitW, exitH);
    fill(0);
    ellipse(exitX - camera.x + exitW - 50, exitY - camera.y + 10, exitW, exitH);
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
        renderTextBox("Bring me all of the variable declarations that would", 
          "compile in Java.");
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
        textBoxYPos = 20;
        renderTextBox("What would you like to learn about?");
        dialogChoiceYPos = 100;
        if (renderDialogChoice("constants")) {
          currentStageState = explainConstantState;
        }
        if (renderDialogChoice("byte")) {
          currentStageState = explainByteState;
        }
        if (renderDialogChoice("short")) {
          currentStageState = explainShortState;
        }
        if (renderDialogChoice("int")) {
          currentStageState = explainIntState;
        }
        if (renderDialogChoice("long")) {
          currentStageState = explainLongState;
        }
        if (renderDialogChoice("float")) {
          currentStageState = explainFloatState;
        }
        if (renderDialogChoice("double")) {
          currentStageState = explainDoubleState;
        }
        if (renderDialogChoice("go back")) {
          currentStageState = greetingState;
        }
        break;
      }
    case explainConstantState:
      {
        textBoxYPos = 50;
        renderTextBox("In Java, plain numbers are in base 10. For example: 2150 is two-thousand, one-hundred, fifty.", 
          "Hexidecimal numbers are base 16 and start with either \'0x\' or\'0X\'.", 
          "Hexidecimal numbers use the character 0 - 9 and a - f. Capital and lowercase", 
          "will both work. 0xAb4 is two-thousand, seven-hundred, fourty in base 10. Base 8", 
          "constants begin with \'0\'. 0176 is one-hundred, twenty-six in base 10.", 
          "Binary constants start with either \'0b\' or \'0B\'. They can only consist", 
          "of zeros and ones. 0b1101 is thirteen in base 10. All constants without", 
          "deciamls are cast as integers by default. Constants with decimals are cast", 
          "as a double by default. \'d\' or \'D\' can also cast a constant to a double.", 
          "\'f\' of \'F\' can be used to cast a constant to a float. \'l\' or \'L\' will", 
          "cast a constant to a long. Constants can have underscores in them. However, a", 
          "constant cannot begin or end with an underscore. Also, underscores cannot go", 
          "on either side of a decimal point. Constant numbers can also be defined as",
          "positive or negative with \'+\' and \'-\' before the number.");
        if (renderDialogChoice("Got it.")) {
          currentStageState = inquireState;
        }
        break;
      }
    case explainByteState:
      {
        renderTextBox("Bytes in Java are an 8-bit signed integer type. So a byte can be any whole number", 
          "from -128 to +127.");
        if (renderDialogChoice("Got it.")) {
          currentStageState = inquireState;
        }
        break;
      }
    case explainShortState:
      {
        renderTextBox("A short in Java is a 16-bit signed integer type. So any whole number from -32768 to", 
          "+32767 can be the value of a short.");
        if (renderDialogChoice("Got it.")) {
          currentStageState = inquireState;
        }
        break;
      }
    case explainIntState:
      {
        renderTextBox("An int (or integer) in Java is a 32-bit signed integer type. Any number from -2147483648", 
          "to +2147483647 can be the value of an int.");
        if (renderDialogChoice("Got it.")) {
          currentStageState = inquireState;
        }
        break;
      }
    case explainLongState:
      {
        renderTextBox("A long  in Java is a 64-bit signed integer type. Any number from", 
          "-9223372036854775808 to +9223372036854775807 can be the value of a long. Any", 
          "constant number without a decimal can be cast to a long by adding \'l\' or \'L\'", 
          "at the end of the number.", 
          "For example:", 
          "long x = 8248293598233098L;");

        if (renderDialogChoice("Got it.")) {
          currentStageState = inquireState;
        }
        break;
      }
    case explainFloatState:
      {
        renderTextBox("In Java, a float is a 32-bit decimal value. Since all constant numbers with", 
          "decimals are cast to double by default, all floats that are set to equal a", 
          "constant with a decimal point must be cast to a float. Casting can be done with", 
          "\'f\' or \'F\'.", 
          "For example:", 
          "float y = 3.1459f;");
        if (renderDialogChoice("Got it.")) {
          currentStageState = inquireState;
        }
        break;
      }
    case explainDoubleState:
      {
        renderTextBox("In Java, a double is a 64-bit decimal value. Constant numbers with", 
          "decimal points are cast to double by default. However, constants can also", 
          "be cast to a double with \'d\' or \'D\', but it is not required when setting a double", 
          "variable equal to a constant.", 
          "For example:", 
          "double z = 700.0D;");
        if (renderDialogChoice("Got it.")) {
          currentStageState = inquireState;
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
          while (collectedConstants.size() > 0) {
            NumberConstant v = collectedConstants.get(0);
            constants.add(v);
            collectedConstants.remove(0);
          }
        }
        break;
      }
    case checkState:
      {
        updateVariables(false);
        if (collected) {
          renderTextBox("Wow! Thanks for getting all the right ones!",
          "Come back anytime."); 
          completed = true;
        } else {
          if (renderPlayerButton("TRY AGAIN", hostX + host.width + 100, hostY + 50)) {
            randomizeVariables();
            currentStageState = gatherState;
          }
          String[] wv = new String[wrongConstants.size()];
          wv = wrongConstants.toArray(wv);
          String[] mv = new String[missedConstants.size()];
          mv = missedConstants.toArray(mv);
          if (missedConstants.size() == 0 && wrongConstants.size() > 0) {
            renderTextBox(20, "These are no good:");
            renderTextBox(105, color(100, 100, 100, 196), color(255, 100, 100), wv);
          } else if (missedConstants.size() > 0 && wrongConstants.size() == 0) {
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

    float ew = exitX - camera.x - exitW / 2;
    float eh = exitY - camera.y - exitH / 2;
    if (checkIntersection(player.x, player.y, player.w, player.h, ew, eh, exitW, exitH)) {
      fill(255);
      textSize(promptTextSize);
      text("Press SPACE to Exit Stage", ew, eh);
      if (checkInteraction()) {
        returnToWorld();


        ret = false;
      }
    }
    image(player.image, player.x, player.y, player.w, player.h);

    return ret;
  }

  public void render() {
  }

  void updateVariables() {
    updateVariables(true);
  }
  void updateVariables(boolean intersection) {
    textFont(courier);

    for (int i = 0; i < constants.size(); i++) {
      NumberConstant v = constants.get(i);
      textSize(v.h);
      float nx = v.x - camera.x;
      float ny = v.y - camera.y;
      fill(75, 75, 75, 200);
      rect(nx - 5, ny - v.h, v.w + 10, v.h * 2, 3);
      fill(variableColor);
      text(v.value, nx, ny);

      if (intersection && checkIntersection(player.x, player.y, player.w, player.h, nx, ny, v.w, v.h)) {
        textFont(arial);
        textSize(promptTextSize);
        fill(255);
        text("Press SPACE to collect variable", nx, ny - 20);   
        textFont(courier);

        if (checkInteraction()) {
          constants.remove(v); 
          collectedConstants.add(v);
        }
      }
    }
    textFont(arial);
  }

  boolean checkForAllCollectedVariables() {
    boolean ret = true;
    wrongConstants.clear();
    missedConstants.clear();

    if (collectedConstants.size() != totalValid) {
      for (NumberConstant v : constants) {
        if (v.valid) {
          for (NumberConstant cv : collectedConstants) {
            if (!v.value.equals(cv)) {
              missedConstants.add(v.value);
              break;
            }
          }
        }
      }
      ret = false;
    }
    for (NumberConstant v : collectedConstants) {
      if (!v.valid) {
        wrongConstants.add(v.value);
        ret = false;
      }
    }
    return ret;
  }
}
