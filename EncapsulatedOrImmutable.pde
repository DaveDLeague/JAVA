class EncapsulatedOrImmutable extends Stage {
  
  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int gameState = 3;
  
  int tutorialPart = 0;
  
  EncapsulatedOrImmutable() {
    exitX = 600;
    exitY = 200;
    exitW = 50;
    exitH = 90;
    player.x = exitX;
    player.y = exitY;
    camera.x = 0;
    camera.y = 0;
    hostX = 50;
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
            if (renderDialogChoice("Is there anything else I need to know?")) {
              tutorialPart++;
            }
            break;
          case 2:
            renderTextBox("Just one more thing - you can't extend immutable classes.", "This means that the class should also be marked final.");
            if (renderDialogChoice("Okay, I understand now!")) {
              tutorialPart++;
            }
            break;
          case 3:
            renderTextBox("To test your knowledge, I'll give you a class and", "ask you to either make it encapsulated or immutable.");
            if (renderDialogChoice("That sounds good, let's do it!")) {
              currentStageState = gameState;
            }
        }
        break;
      case gameState:
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
  
}
