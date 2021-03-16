class TernaryTornado extends Stage {
  final int findHostState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int findDoorState = 3;
  final int playGameState = 4;

  float doorX;
  float doorY;
  float doorW = 50;
  float doorH = 90;

  TernaryTornado() {
    for (int i = 0; i < 1; i++) {
      String[] ts = generateTernaryString(0);
      for (String s : ts) {
        println(s);
      }
    }
    camera.x = 0;
    camera.y = 0;
    exitX = 100;
    exitY = 100;
    exitW = 50;
    exitH = 90;
    host = loadImage("butterfly.png");
    hostX = exitX + 300;
    hostY = exitY + 150;
    player.x = exitX;
    player.y = exitY;

    doorX = hostX + 200;
    doorY = hostY + 200;

    background = new Background(resolutionWidth, resolutionHeight);
    background.clr = color(80);
    currentBackground = background;
  }

  String generateBoolean(String name) {
    return "boolean " + name + " = " + ((int)random(2) == 0 ? "true" : "false") + ";";
  }

  String generateInt(String name) {
    return "int " + name + " = " + (int)random(100) + ";";
  }

  String[] generateTernaryString(int level) {
    ArrayList<String> tern = new ArrayList<String>();
    switch(level) {
    default:
    case 0:
      {
        String[] varNames = generateWordArray(2);
        String bool = generateBoolean(varNames[0]);
        String b = "boolean " + varNames[1] + " = ";
        String c = ((int)random(2) == 0 ? "!" : "") + varNames[0] + " ? " + ((int)random(2) == 0 ? "true : false;" : "false : true;");
        
        tern.add(bool);
        tern.add(b + c);
        break;
      }
    }
    String[] ternA = new String[tern.size()];
    ternA = tern.toArray(ternA);

    return ternA;
  }

  boolean update() {
    boolean ret = true;
    background(background.clr);
    player.update();
    camera.update();
    fill(200);
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);
    image(host, hostX - camera.y, hostY - camera.x, host.width, host.height);



    switch(currentStageState) {
    case findHostState: 
      {
        if (checkIntersection(player.x, player.y, player.w, player.h, hostX, hostY, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to Talk to the Butterfly", hostX, hostY);
          if (checkInteraction()) {
            currentStageState = greetingState;
          }
        }
        if (checkForExit() && checkInteraction()) {
          returnToWorld();
          ret = false;
        }
        break;
      }
    case greetingState:
      {
        renderTextBox("Hello there, you! Would you care to ", 
          "learn about Java's ternaries?");
        if (renderDialogChoice("Sure.")) {
          currentStageState = tutorialState;
        }
        if (renderDialogChoice("No need.")) {
          currentStageState = findDoorState;
        }
        if (checkForExit() && checkInteraction()) {
          returnToWorld();
          ret = false;
        }
        break;
      }
    case tutorialState:
      {
        renderTextBox("Ternaries are an abreviated way to write an if-else", 
          "statement in Java.");


        if (checkForExit() && checkInteraction()) {
          returnToWorld();
          ret = false;
        }
        break;
      }
    case findDoorState:
      {
        fill(200);
        rect(doorX, doorY, doorW, doorH);
        if (checkIntersection(player.x, player.y, player.w, player.h, doorX, doorY, doorW, doorH)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to Begin", doorX, doorY);
          if (checkInteraction()) {
            currentStageState = playGameState;
          }
        }
        if (checkForExit() && checkInteraction()) {
          returnToWorld();
          ret = false;
        }
        break;
      }
    case playGameState:
      {
        background(100); 
        break;
      }
    }

    image(player.image, player.x, player.y, player.w, player.h);


    return ret;
  }
}
