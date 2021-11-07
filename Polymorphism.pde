class Polymorphism extends Stage {
  
  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int gameState = 3;
  
  int tutorialPart = 0;
  ArrayList<String> a = new ArrayList<String>();
  int class1 = 0;
  int class2 = 0;
  int class3 = 0;
  int none = 0;
  String className = "";
  boolean reset = true;
  
  Polymorphism() {
    exitX = 75;
    exitY = 400;
    exitW = 50;
    exitH = 90;
    player.x = exitX;
    player.y = exitY;
    camera.x = 0;
    camera.y = 0;
    hostX = exitX + 750;
    hostY = exitY;
    host = loadImage("hamster.png");
    background = new Background(resolutionWidth, resolutionHeight);
    background.clr = color(#f56464);
    currentBackground = background;
    a.add("Class1");
    a.add("Class2");
    a.add("Class3");
    a.add("IntA");
    a.add("IntB");
  }
  
  boolean update() {
    background(background.clr);
    player.update();
    camera.update();
    float cx = hostX - camera.x;
    float cy = hostY - camera.y;
    image(host, cx, cy, host.width, host.height);
    fill(255);
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH);
    switch (currentStageState) {
      case searchState:
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Hamster", cx, cy); 
          if (checkInteraction()) {
            currentStageState = greetingState;
          }
        }
        break;
      case greetingState:
        renderTextBox("Hello! Do you already know about polymorphism?");
        if (renderDialogChoice("No, can you go over it for me?")) {
          tutorialPart = 0;
          currentStageState = tutorialState;
        } else if (renderDialogChoice("Yeah!")) {
          tutorialPart = 3;
          currentStageState = tutorialState;
        }
        break;
      case tutorialState:
        switch(tutorialPart) {
          case 0:
            renderTextBox("Polymorphism is the ability of an object in Java to take on multiple forms.");
            if (renderDialogChoice("Hmm, can you explain what that means?")) {
              tutorialPart++;
            }
            break;
          case 1:
            renderTextBox("This means that when a subclass extends a superclass and implements from", "interfaces, an object from the subclass can be used as an object of the superclass", "or the interfaces.");
            if (renderDialogChoice("Can you give me an example?")) {
              tutorialPart++;
            }
            break;
          case 2:
            renderTextBox("For example, say we have a class Hamster that extends from another class, Animal.", "If there is a situation where an Animal object is needed,", "we can use a Hamster instead of an Animal thanks to polymorphism.");
            if (renderDialogChoice("Okay, that makes more sense.")) {
              tutorialPart++;
            }
            break;
          case 3:
            renderTextBox("To test your knowledge, I'll ...");
            if (renderDialogChoice("Okay, let's do it!")) {
              currentStageState = gameState;
            }
            break;
        }
        break;
      case gameState:
        if (reset) {
          reset = false;
          className = pickRandomClass();
          class1 = 0;
          class2 = 0;
          class3 = 0;
          none = 0;
        }
        fill(250);
        textSize(24);
        text("class Class1 {}", 100, 100);
        text("class Class2 extends Class1 {}", 100, 130);
        text("class Class3 extends Class2 implements IntB {}", 100, 160);
        text("interface IntA {}", 100, 190);
        text("interface IntB extends IntA {}", 100, 220);
        text("Which class(es) or interface(s) can polymorph into " + className + "?", 150, 375);
        if (renderPlayerButton("Class1", switchText(class1), 175, 425, switchColor(class1), color(255))) {
            class1++;
        }
        if (renderPlayerButton("Class2", switchText(class2), 350, 425, switchColor(class2), color(255))) {
            class2++;
        }
        if (renderPlayerButton("Class3", switchText(class3), 525, 425, switchColor(class3), color(255))) {
            class3++;
        }
        if (renderPlayerButton("None", switchText(none), 700, 425, switchColor(none), color(255))) {
            none++;
        }
        break;
    }
    image(player.image, player.x, player.y, player.w, player.h);
    if (checkForExit()) {
      if (checkInteraction()) {
        returnToWorld();
        return false;
      }
    }
    return true;
  }
  
  private color switchColor(int i) {
    if (i % 2 == 0) {
      return color(0, 0, 255);
    } else {
      return color(210, 0, 210);
    }
  }
  
  private String switchText(int i) {
    if (i % 2 == 0) {
      return "Press SPACE to Select";
    } else {
      return "Press SPACE to Deselect";
    }
  }
  
  private String pickRandomClass() {
    int i = (int)(Math.random()*5);
    switch (i) {
      case 0:
        return "Class1";
      case 1:
        return "Class2";
      case 2:
        return "Class3";
      case 3:
        return "IntA";
      case 4:
        return "IntB";
      default:
        return "";
    }
  }
  
  //make sure to test everything
  private boolean[] checkAnswer(String className) {
    switch (className) {
      case "Class1":
        return new boolean[]{true, true, true, false, false};
      default:
        return new boolean[]{false, false, false, false, false};
    }
  }
}
