import java.util.*;

class ArrayArrayList extends Stage {
  
  final int searchState = 0;
  final int greetingState = 1;
  final int tutorialState = 2;
  final int gameState = 3;
  
  int tutorialPart = 0;
  int score = 0;
  ArrayList<Integer> questionNumbers = new ArrayList<Integer>(Arrays.asList(0, 1, 2));
  boolean drawNumber = false;
  boolean quizOver = false;
  int questionIndex = 0;

  ArrayArrayList() {
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
    host = loadImage("lion.png");
    background = new Background(resolutionWidth*1.1, resolutionHeight*1.1);
    background.clr = color(#9d58c4);
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
        renderTextBox("Have you mastered using Arrays and ArrayList?");
        if (renderDialogChoice("Hmm, I think I might need a refresher...")) {
          tutorialPart = 1;
          currentStageState = tutorialState;
        } else if (renderDialogChoice("Yes, I'm an Array and ArrayList expert!")) {
          tutorialPart = 5;
          currentStageState = tutorialState;
        }
        break;
      case tutorialState:
        switch(tutorialPart) {
          case 1:
            renderTextBox("Both Arrays and ArrayLists are used to store lists of data.", "Arrays have a fixed size, but they are mutable.", "This means you can change the array object after it's been created.");
            if (renderDialogChoice("Hmm, tell me more!")) {
              tutorialPart++;
            }
            break;
          case 2:
            renderTextBox("Arrays can store primitives like int and boolean.", "They can have multiple dimensions: you can store arrays inside of arrays!", "Also, remember that you can find the size of an array by using the variable \"length.\"");
            if (renderDialogChoice("What's next?")) {
              tutorialPart++;
            }
            break;
          case 3:
            renderTextBox("ArrayLists are dynamic in size, but are unmutable.", "They can store any type of object, but can't store primitives.", "When initializing an ArrayList, you need to specify what kind of class", "it'll hold using angled brackets (<>).");
            if (renderDialogChoice("So if I wanted to initialize an ArrayList of Strings, I would say ArrayList<String>...")) {
              tutorialPart++;
            }
            break;
          case 4:
            renderTextBox("Exactly!", "ArrayLists also have lots of methods that you can use to interact with them,", "like \"add()\", \"clear()\", \"indexOf()\", \"remove()\", \"size()\", and so on.", "You can also turn an ArrayList into an array by using \"toArray()\"!");
            if (renderDialogChoice("Ok, I think I've got it now...")) {
              tutorialPart++;
            }
            break;
          case 5:
            renderTextBox("Alright, it's time for a quiz! I'll give you a characteristic and you have to decide", "whether it describes an Array or an ArrayList, or both!");
            if (renderDialogChoice("Alright, let's do it!")) {
              currentStageState = gameState;
            }
            break;
        }
        break;
      case gameState:
        if (!drawNumber) 
          if (!questionNumbers.isEmpty()) {
            questionIndex = questionNumbers.remove((int)Math.random()*questionNumbers.size());
            drawNumber = true;
          } else {
            quizOver = true;
          }
        if (quizOver) {
          renderTextBox("Yay :)");
        } else {
          switch(questionIndex) {
            case 0:
              renderTextBox("It has a fixed size.");
              if (renderDialogChoice("Array!")) {
                score++;
                drawNumber = false;
              }
              if (renderDialogChoice("ArrayList!")) {
                drawNumber = false;
              }
              if (renderDialogChoice("Both!")){ 
                drawNumber = false;
              }
              break;
            case 1:
              renderTextBox("It uses the method \".get()\" to return the object at a certain index.");
              if (renderDialogChoice("Array!")) {
                drawNumber = false;
              }
              if (renderDialogChoice("ArrayList!")) {
                score++;
                drawNumber = false;
              }
              if (renderDialogChoice("Both!")){ 
                drawNumber = false;
              }
              break;
            case 2:
              renderTextBox("It can change size.");
              if (renderDialogChoice("Array!")) {
                drawNumber = false;
              }
              if (renderDialogChoice("ArrayList!")) {
                score++;
                drawNumber = false;
              }
              if (renderDialogChoice("Both!")){ 
                drawNumber = false;
              }
              break;
            case 3:
              renderTextBox("It can be multi-dimensional.");
              if (renderDialogChoice("Array!")) {
                score++;
                drawNumber = false;
              }
              if (renderDialogChoice("ArrayList!")) {
                drawNumber = false;
              }
              if (renderDialogChoice("Both!")){ 
                drawNumber = false;
              }
              break;
            case 4:
              renderTextBox("The index of the first value is 0.");
              if (renderDialogChoice("Array!")) {
                drawNumber = false;
              }
              if (renderDialogChoice("ArrayList!")) {
                drawNumber = false;
              }
              if (renderDialogChoice("Both!")){ 
                score++;
                drawNumber = false;
              }
            case 5:
              renderTextBox("It can be initialized using a literal.");
              if (renderDialogChoice("Array!")) {
                score++;
                drawNumber = false;
              }
              if (renderDialogChoice("ArrayList!")) {
                drawNumber = false;
              }
              if (renderDialogChoice("Both!")){ 
                drawNumber = false;
              }
              break;
            case 6:
              renderTextBox("It can be directly converted between the two types of lists.", "e.g. Array->ArrayList, ArrayList->Array");
              if (renderDialogChoice("Array!")) {
                drawNumber = false;
              }
              if (renderDialogChoice("ArrayList!")) {
                score++;
                drawNumber = false;
              }
              if (renderDialogChoice("Both!")){ 
                drawNumber = false;
              }
              break;
            case 7:
              renderTextBox("It can hold primitives.");
              if (renderDialogChoice("Array!")) {
                score++;
                drawNumber = false;
              }
              if (renderDialogChoice("ArrayList!")) {
                drawNumber = false;
              }
              if (renderDialogChoice("Both!")){ 
                drawNumber = false;
              }
              break;
          }
        }
    }
    return true;
  }
  
}
