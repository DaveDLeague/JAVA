class EncapsulatedOrImmutable extends Stage {
  
  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int gameState = 3;
  
  int tutorialPart = 0;
  int button1 = 0;
  int button2 = 0;
  int button3 = 0;
  
  EncapsulatedOrImmutable() {
    exitX = 700;
    exitY = 150;
    exitW = 50;
    exitH = 90;
    player.x = exitX;
    player.y = exitY;
    camera.x = 0;
    camera.y = 0;
    hostX = 750;
    hostY = 450;
    host = loadImage("crab.png");
    background = new Background(resolutionWidth, resolutionHeight);
    background.clr = color(#a42f9b);
    currentBackground = background;
  }
  
  boolean update() {
    background(background.clr);
    player.update();
    camera.update();
    float cx = hostX - camera.x;
    float cy = hostY - camera.y;
    image(host, cx, cy, 0.5*host.width, 0.5*host.height);
    fill(255);
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH);
    image(player.image, player.x, player.y, player.w, player.h);
    switch(currentStageState) {
      case searchState:
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Crab", cx, cy); 
          if (checkInteraction()) {
            currentStageState = greetingState;
          }
        }
        break;
      case greetingState:
        renderTextBox("Hello!", "Do you know the difference between an encapsulated class and an immutable class?");
        if (renderDialogChoice("No, can you go over it again?")) {
          tutorialPart = 0;
          currentStageState = tutorialState;
        } else if (renderDialogChoice("Yep, I already know.")) {
          tutorialPart = 2;
          currentStageState = tutorialState;
        }
        break;
      case tutorialState:
        switch(tutorialPart) {
          case 0:
            renderTextBox("An encapsulated class is a class that has private member variables", "and public methods called getters and setters to access and modify those variables.");
            if (renderDialogChoice("Okay!")) {
              tutorialPart++;
            }
            break;
          case 1:
            renderTextBox("An immutable class uses the same principles as an encapsulated class,", "but you can't change any data of an object made from immutable class.", "This means that immutable classes have no setter methods,", "and its member variables are marked final as well as private.");
            if (renderDialogChoice("Okay, I understand now!")) {
              tutorialPart++;
            }
            break;
          case 2:
            renderTextBox("To test your knowledge, I'll give you a class and", "ask you to either make it encapsulated or immutable.");
            if (renderDialogChoice("That sounds good, let's do it!")) {
              currentStageState = gameState;
            }
            break;
        }
        break;
      case gameState:
        fill(250);
        textSize(36);
        text("public class Class1 {", 100, 70);
        if (renderPlayerButton(buttonText(button1), "Press SPACE to Switch", 150, 95)) {
          button1++;
        }
        fill(250);
        textSize(36);
        text("int x;", 315, 125);
        if (renderPlayerButton(buttonText(button2), "Press SPACE to Switch", 150, 160)) {
          button2++;
        }
        fill(250);
        textSize(36);
        text("void setX(int x){", 315, 190);
        text("this.x = x;", 200, 250);
        text("}", 135, 300);
        if (renderPlayerButton(buttonText(button3), "Press SPACE to Switch", 150, 335)) {
          button3++;
        }
        fill(250);
        textSize(36);
        text("int getX(){", 315, 365);
        text("return x;", 200, 420);
        text("}", 135, 470);
        text("}", 100, 530);
        
        fill(225, 200, 180);
        textSize(24);
        if (checkIfEncapsulated()) {
          text("Great!", 765, 400);
        } else {
          text("Make this class encapsulated!", 625, 400);
        }
        break;
    }
    if (checkForExit()) {
      if (checkInteraction()) {
        returnToWorld();
        return false;
      }
    }
    return true;
  }
  
  private boolean checkIfEncapsulated() {
    return (button1 % 3 == 0) && (button2 % 3 == 1) && (button3 % 3 == 1);
  }
  
  private String buttonText(int b) {
    if (b % 3 == 0) {
      return "private";
    } else if (b % 3 == 1) {
      return "public";
    } else {
      return "REMOVE";
    }
  }
  
}
