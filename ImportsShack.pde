class ImportsShack extends Stage {
  class CodeLine extends PushBox {
    final float size = 24;
    final color boxColor = color(0, 0, 64);
    final color textColor = color(255, 196, 196);
    String text;
    int order;

    CodeLine(float x, float y, String text, int order) {
      this.order = order;
      textFont(courier);
      this.text = text;
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

  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int tutorialState2 = 3;
  final int tutorialState3 = 4;
  final int doorSearchState = 5;
  final int packageGameState1 = 6;
  boolean skipTutorial;
  boolean stageComplete;
  boolean incorrectAnswer;

  Background gameBackground = new Background(resolutionWidth, resolutionHeight * 2);

  ArrayList<CodeLine> code = new ArrayList<CodeLine>();

  ImportsShack(StageImage image) {
    super(image); 
    initialize();
  }

  void initialize() {
    x = 400;
    y = 750;
    exitX = x;
    exitY = y;
    exitW = 50;
    exitH = 90;
    hostX = exitX + 200;
    hostY = exitY;
    w = image.image.width;
    h = image.image.height;
    state = GameStates.IMPORTS_SHACK_STATE;
    host = loadImage("sloth.png");

    currentStageState = packageGameState1;
    currentBackground = gameBackground;

    code.add(new CodeLine(350, 400, "//made by robots", -1));
    code.add(new CodeLine(100, 200, "package animal;", 0));
    code.add(new CodeLine(200, 500, "import java.util.ArrayList;", 1));
    code.add(new CodeLine(350, 100, "public class Dog {", 2));
    code.add(new CodeLine(140, 400, "int a = 24;", 3));
    code.add(new CodeLine(700, 100, "}", 4));
  }

  boolean update() {
    boolean ret = true;
    float cx = hostX - camera.x;
    float cy = hostY - camera.y;
    fill(200);
    image(host, cx, cy, host.width, host.height);
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);

    switch(currentStageState) {
    case searchState:
      {
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Sloth", cx, cy); 
          if (keyPressed && key == ' ') {
            key = 0;
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
        renderTextBox("Java classes are placed into packages.", 
          "A package is really just a folder on the computer.", 
          "In order for one class to make objects of another class,", 
          "it has to declare what package that class is in.", 
          "Unless the two classes are in the same package, that is.");
        if (renderDialogChoice("Uh huh.")) {
          currentStageState = tutorialState2;
        }

        break;
      }
    case tutorialState2:
      {
        renderTextBox("There's a package named java.lang that is, ", 
          "imported automatically for every Java program.", 
          "That means any class can use the classes in that package", 
          "without importing or declaring that package.", 
          "This package has the String class, the primitive", 
          "Data types wrapper classes, and all the other", 
          "commonly used classes, You can look it", 
          "up in the docs to get a full list of ", 
          "classes in this package.");
        if (renderDialogChoice("I'm with you so far")) {
          currentStageState = tutorialState3;
        }

        break;
      }
    case tutorialState3:
      {
        renderTextBox("Go through the door to the right to start.", 
          "Put all the classes in the correct packages to finish.", 
          "Got it?");
        if (renderDialogChoice("Got it.")) {
          currentStageState = doorSearchState;
        }

        break;
      }

    case doorSearchState:
      {
        if (skipTutorial) {
          renderTextBox("Oh! Um. Okay. Well, you better get to it then.");
        }
        fill(128, 40, 75);
        float dx = hostX + 400 - camera.x;
        float dy = hostY - camera.y;
        float dw = 50;
        float dh = 100;
        rect(dx, dy, dw, dh, 18, 18, 0, 0);

        if (checkIntersection(player.x, player.y, player.w, player.h, dx, dy, dw, dh)) {
          textSize(promptTextSize);
          fill(255);
          text("Press SPACE to Begin Sorting Packages", dx, dy);
          if (keyPressed && key == ' ') {
            key = 0;
            currentStageState = packageGameState1;
          }
        }
        break;
      }
    case packageGameState1:
      {
        background(128, 40, 75);

        if (stageComplete) {
          renderTextBox("You did it!", "Move to the exit for the next stage.");
          rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);
          if (checkForExit()) {
            if (keyPressed && key == ' ') {
              stageComplete = false; 
              key = 0;
              currentBackground = worldMapBackground;
              currentState = GameStates.WORLD_MAP_STATE;
            }
          }
          for (CodeLine c : code) {
            c.render();
          }
        } else {

          if (renderPlayerButton("SUBMIT ANSWER", 100, 700)) {
            if (checkForStageWin()) {
              exitX = 300;
              exitY = 800;
              stageComplete = true;
              incorrectAnswer = false;
              image.completed = true;
            } else {
              incorrectAnswer = true;
            }
          }
          if (renderPlayerButton("RESET BLOCKS", 500, 700)) {
            incorrectAnswer = false;
          }
          if (renderPlayerButton("RETURN TO WOLD MAP", 200, 900)) {
            currentBackground = worldMapBackground;
            currentState = GameStates.WORLD_MAP_STATE;
          }

          for (CodeLine c : code) {
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
      if (keyPressed && key == ' ') {
        key = 0;
        currentState = GameStates.WORLD_MAP_STATE;
        ret = false;
      }
    }
    return ret;
  }

  boolean checkForStageWin() {
    boolean ret = true;

    for (int i = 0; i < code.size() - 1; i++) {
      CodeLine c1 = code.get(i);
      if (c1.order < 0) continue;
      for (int j = i + 1; j < code.size(); j++) {
        CodeLine c2 = code.get(j);
        if (c2.order < 0) continue;
        if (c2.order > c1.order && c2.y > c1.y) continue;
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
