import java.util.ArrayList;

class FallingExceptions extends Stage {
  
  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int gameState = 3;
  final String[] exceptions = {"IOException", "NullPointerException", "FileNotFoundException", "MalformedURLException", "IllegalArgumentException", "ArrayIndexOutOfBoundsException", "IndexOutOfBoundsException", "StringIndexOutOfBoundsException", "RuntimeException", "Exception", "ArithmeticException", "IllegalStateException", "ClassCastException", "InterruptedException", "ClassNotFoundException", "InstantiationException"};
  final String[] uncheckedExceptions = {"NullPointerException", "RuntimeException", "ArithmeticException", "IllegalArgumentException", "IllegalStateException", "IndexOutOfBoundsException", "ArrayIndexOutOfBoundsException", "StringIndexOutOfBoundsException"};
  ArrayList<String> exceptionsLeft = new ArrayList<String>();
  ArrayList<TextBox> textBoxes = new ArrayList<TextBox>();
  int index = (int)(Math.random()*exceptions.length);
  int score = 0;
  
  int tutorialPart = 0;
  TextBox tb1;
  TextBox tb2;
  TextBox tb3;
  int count = 0;
  
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
    for (String s: exceptions) {
      exceptionsLeft.add(s);
    }
    tb1 = new TextBox(400, exceptionsLeft.remove((int)(Math.random()*exceptionsLeft.size())));
    tb2 = new TextBox(50, exceptionsLeft.remove((int)(Math.random()*exceptionsLeft.size())));
    tb3 = new TextBox(750, exceptionsLeft.remove((int)(Math.random()*exceptionsLeft.size())));
    textBoxes.add(tb1);
    textBoxes.add(tb2);
    textBoxes.add(tb3);
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
          tutorialPart = 0;
          currentStageState = tutorialState;
        } else if (renderDialogChoice("Yep, I already know.")) {
          tutorialPart = 3;
          currentStageState = tutorialState;
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
            if (renderDialogChoice("I think I get it now! Now what?")) {
              tutorialPart++;
            }
            break;
          case 3:
            renderTextBox("Text boxes with both checked and unchecked exceptions will fall.", "Your goal is to collect all of the UNCHECKED exceptions.");
            if (renderDialogChoice("Alright, let's play!")) {
              currentStageState = gameState;
            }
        }
        break;
      case gameState:
        if (count < 25) {
          count++;
        }
        textSize(30);
        fill(255);
        text("Score: " + score, resolutionWidth - 200, resolutionHeight-20);
        tb1.render();
        tb1.yPos = tb1.yPos + 3;
        if (count > 12) {
          tb2.render();
          tb2.yPos = tb2.yPos + 3;
        }
        if (count > 24) {
          tb3.render();
          tb3.yPos = tb3.yPos + 3;
        }
        for (int i = 0; i < textBoxes.size(); i++) {
          if (textBoxes.get(i).yPos > 600) {
            textBoxes.get(i).yPos = 0;
            textBoxes.get(i).counter++;
          }
          if (textBoxes.get(i).counter > 1) {
             exceptionsLeft.add(textBoxes.get(i).text);
             textBoxes.get(i).reset(exceptionsLeft.remove((int)(Math.random()*exceptionsLeft.size())));
             textBoxes.get(i).counter = 0;
          }
          if (checkIntersection(player.x, player.y, player.w, player.h, textBoxes.get(i).xPos, textBoxes.get(i).yPos, 10+15*textBoxes.get(i).text.length(), 50)) {
            fill(255);
            textSize(promptTextSize);
            text("Press SPACE to collect", textBoxes.get(i).xPos, textBoxes.get(i).yPos-20);
            if (checkInteraction()) {
              textBoxes.get(i).yPos = 0;
              Arrays.sort(uncheckedExceptions);
              if(Arrays.binarySearch(uncheckedExceptions, textBoxes.get(i).text) >= 0) {
                score++;
              } else {
                score = 0;
                exceptionsLeft.clear();
                for (String s: exceptions) {
                  exceptionsLeft.add(s);
                }
              }
              textBoxes.get(i).reset(exceptionsLeft.remove((int)(Math.random()*exceptionsLeft.size())));
            }
          }
        }
        System.out.println(exceptionsLeft);
        if (score == uncheckedExceptions.length) {
          tb1.yPos = -50;
          tb2.yPos = -50;
          tb3.yPos = -50;
          renderTextBox("Awesome! I think you've gotten the hang of this.", "Now go forth and do more JAVA!"); 
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

class TextBox {
  int xPos;
  int yPos;
  String text;
  int counter = 0;
  
  TextBox(int x, String t) {
    xPos = x;
    yPos = 0; 
    text = t;
  }
  
  void render() {
    renderTextBox((float)xPos, (float)yPos, text);
  }
  
  void reset(String t) {
    xPos = (int)(Math.random()*600+25);
    yPos = 0; 
    text = t;
  }
}
