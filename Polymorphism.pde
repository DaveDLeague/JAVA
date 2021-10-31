class Polymorphism extends Stage {
  
  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int gameState = 3;
  
  int tutorialPart = 0;
  ArrayList<String> a = new ArrayList<String>();
  
  Polymorphism() {
    exitX = 100;
    exitY = 400;
    exitW = 50;
    exitH = 90;
    player.x = exitX;
    player.y = exitY;
    camera.x = 0;
    camera.y = 0;
    hostX = exitX + 700;
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
        fill(250);
        textSize(24);
        text("public class Class1 {}", 100, 100);
        text("public class Class2 extends Class1 {}", 100, 130);
        text("public class Class3 extends Class2 implements IntB {}", 100, 160);
        text("public interface IntA {}", 100, 190);
        text("public interface IntB extends IntA {}", 100, 220);
        if (renderPlayerButton(switchText(0), "Press SPACE to Select", 200, 425)) {
            
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
  
  private String switchText(int i) {
    return "";
  }
}
