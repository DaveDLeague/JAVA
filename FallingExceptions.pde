class FallingExceptions extends Stage {
  
  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int gameState = 3;
  final String[] exceptions = {"IOException", "NullPointerException", "FileNotFoundException", "MalformedURLException", "ArrayIndexOutOfBoundsException", "IndexOutOfBoundsException", "StringIndexOutOfBoundsException", "RuntimeException", "Exception", "ArithmeticException", "IllegalArgumentException", "IllegalStateException", "ClassCastException", "InterruptedException", "ClassNotFoundException", "InstantiationException"};
  final String[] uncheckedExceptions = {"NullPointerException", "RuntimeException", "ArithmeticException", "IllegalArgumentException", "IllegalStateException", "IndexOutOfBoundsException", "ArrayIndexOutOfBoundsException", "StringIndexOutOfBoundsException"};
  int index = (int)(Math.random()*exceptions.length);
  int score = 0;
  
  int tutorialPart = 0;
  int boxX = (int)(Math.random()*400+100);
  int boxY = 0;
  int debug = 0;
  
  FallingExceptions() {
    exitX = 800;
    exitY = 400;
    exitW = 50;
    exitH = 90;
    player.x = exitX;
    player.y = exitY;
    camera.x = 0;
    camera.y = 0;
    hostX = exitX - 500;
    hostY = exitY;
    host = loadImage("gorilla.png");
    
    background = new Background(resolutionWidth, resolutionHeight);
    background.clr = color(#c9afc6);
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
        tutorialPart = 0;
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Gorilla", cx, cy); 
          if (checkInteraction()) {
            currentStageState = greetingState;
          }
        }
        break;
      case greetingState:
        renderTextBox("Do you know about Java checked and unchecked exceptions?");
        if (renderDialogChoice("No, can you tell me about them?")) {
          currentStageState = tutorialState;
        } else if (renderDialogChoice("Yep, I already know.")) {
          currentStageState = gameState;
        }
        break;
      case tutorialState:
        switch(tutorialPart) {
          case 0:
            renderTextBox("All exceptions in Java inherit from java.lang.Exception.", "There are two types of exceptions:", "checked exceptions and unchecked exceptions.");
            if (renderDialogChoice("Ok, so what's the difference?")) {
              tutorialPart++;
            }
            break;
          case 1:
            renderTextBox("Unchecked exceptions inherit from java.lang.RuntimeException,", "a subclass of Exception.", "The program is not required to handle them.", "Unchecked exceptions can be thrown by both the programmer and the JVM.");
            if (renderDialogChoice("What about checked exceptions?")) {
              tutorialPart++;
            }
            break;
          case 2:
            renderTextBox("Checked exceptions inherit from java.lang.Exception", "and its subclasses that DO NOT extend from java.lang.RuntimeException.", "The program is required to handle them.", "Checked exceptions are thrown programmatically.");
            if (renderDialogChoice("I think I get it now, let's play!")) {
              currentStageState = gameState;
            }
            break;
        }
        break;
      case gameState:
        textSize(30);
        fill(255);
        text("Score: " + score, resolutionWidth - 200, resolutionHeight-20);
        renderTextBox((float)boxX, (float)boxY, exceptions[index]);
        boxY += 3;
        if (boxY > 600) {
          boxY = 0;
        }
        if (checkIntersection(player.x, player.y, player.w, player.h, boxX, boxY, 20+15*exceptions[index].length(), 50)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to collect", boxX, boxY-20);
          if (checkInteraction()) {
            Arrays.sort(uncheckedExceptions);
            if(Arrays.binarySearch(uncheckedExceptions, exceptions[index]) >= 0) {
              score++;
            } else {
              score--;
            }
            boxX = (int)(Math.random()*400+100);
            boxY = 0;
            index = (int)(Math.random()*exceptions.length);
          }
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
}
