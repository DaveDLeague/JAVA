class EqualsOrEquals extends Stage {
  
  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int gameState = 3;
  
  int tutorialPart = 0;
  int randIndexWordList = 0;
  int score = 0;
  
  boolean firstTime = true;
  int correctButton = 0;
  int buttonPressed = 0;
  
  int questionType = (int)(Math.random()*2);
  
  EqualsOrEquals() {
    exitX = 100;
    exitY = 100;
    exitW = 50;
    exitH = 90;
    player.x = exitX;
    player.y = exitY;
    camera.x = 0;
    camera.y = 0;
    hostX = 900;
    hostY = 450;
    host = loadImage("shark.png");
    background = new Background(resolutionWidth*1.1, resolutionHeight*1.1);
    background.clr = color(#eb7134);
    currentBackground = background;
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
    image(player.image, player.x, player.y, player.w, player.h);
    switch(currentStageState) {
      case searchState:
        firstTime = true;
        randIndexWordList = (int)(Math.random()*WORD_LIST.length);
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Shark", cx, cy); 
          if (checkInteraction()) {
            currentStageState = greetingState;
          }
        }
        break;
      case greetingState:
        renderTextBox("Do you need a refresher on the difference between \"==\" and \"equals()\"?");
        if (renderDialogChoice("Yes, let's go over it again!")) {
          tutorialPart = 0;
          currentStageState = tutorialState;
        } else if (renderDialogChoice("Nope, I'm good.")) {
          tutorialPart = 3;
          currentStageState = tutorialState;
        }
        break;
      case tutorialState:
        switch(tutorialPart) {
          case 0:
            renderTextBox("\"==\" is used to check if two references are pointing to the same object.", "This is usually used to check equality between primitive values,", "because you can't call methods on primitives.");
            if (renderDialogChoice("Okay!")) {
              tutorialPart++;
            }
            break;
          case 1:
            renderTextBox("\"==\" can also be used to check equality between string literals", "because String literals are pooled, meaning that", "if the same String literal is assigned to two variables,", "the String will just be reused.");
            if (renderDialogChoice("I understand, but what about \"equals()\"?")) {
              tutorialPart++;
            }
            break;
          case 2:
            renderTextBox("\"equals()\" is a method from the Object class.", "It checks whether two objects have the same qualities.", "For example, the String version of equals() checks if the characters of each String", "are exactly the same.");
            if (renderDialogChoice("I see!")) {
              tutorialPart++;
            }
            break;
          case 3:
            renderTextBox("To test your knowledge, I'll give you some incomplete if-statements", "that check for equality. Your objective is to decide whether \"==\"", "or \"equals()\" would make the if-statement evaluate to \"true\"—", "or whether you could use both!");
            if (renderDialogChoice("That sounds good, let's do it!")) {
              currentStageState = gameState;
            }
        }
        break;
      case gameState:
        textSize(20);
        text("Score: " + score, resolutionWidth - 200, resolutionHeight-20);
        fill(0, 0, 0, 200);
        rect(225 - camera.x, 200 - camera.y, 465, 200);
          
          renderTabs(randIndexWordList, questionType);
           
        if (renderPlayerButton("==", "\"==\" will work!", 200, 500)) {
          buttonPressed = 1;
        }
        if (renderPlayerButton("equals()", "\"equals\" will work!", 380, 500)) {
          buttonPressed = 2;
        }
        if (renderPlayerButton("both", "both will work!", 650, 500)) {
          buttonPressed = 3;
        }
        if (buttonPressed != 0 && correctButton != 0) {
          if (buttonPressed == correctButton) {
            score++;
          } else {
            score--;
          }
          buttonPressed = 0;
          correctButton = 0;
          randIndexWordList = (int)(Math.random()*WORD_LIST.length);
          questionType = (int)(Math.random()*2);
          renderTabs(randIndexWordList, questionType);
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
  
  void renderTabs(int index, int rand) {
    fill(200);
    textSize(18);
    switch(rand) {
      case 0:
        text("Object o = new Object();", 250 - camera.x, 225 - camera.y);
        text("Object m = o;", 250 - camera.x, 275 - camera.y);
        text("if (o _____ m) {", 250 - camera.x, 325 - camera.y);
        text("//code goes here", 275 - camera.x, 350 - camera.y);
        text("}", 250 - camera.x, 375 - camera.y);
        correctButton = 1;
        break;
      case 1:
        text("String s = \"" + WORD_LIST[index] + "\";", 250 - camera.x, 225 - camera.y);
        text("String y = new String(\"" + WORD_LIST[index] + "\");", 250 - camera.x, 275 - camera.y);
        text("if (s _____ o) {", 250 - camera.x, 325 - camera.y);
        text("//code goes here", 275 - camera.x, 350 - camera.y);
        text("}", 250 - camera.x, 375 - camera.y);
        correctButton = 2;
        break;
      case 2:
        text("String s = \"" + WORD_LIST[index] + "\";", 250 - camera.x, 225 - camera.y);
        text("String y = new String(\"" + WORD_LIST[index] + "\");", 250 - camera.x, 275 - camera.y);
        text("if (s _____ o) {", 250 - camera.x, 325 - camera.y);
        text("//code goes here", 275 - camera.x, 350 - camera.y);
        text("}", 250 - camera.x, 375 - camera.y);
        correctButton = 2;
        break;
    }
  }
  
}
