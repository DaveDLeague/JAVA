/* //<>//
 TODO:
 finish imports shack
 -make game more procedural and logical, 'na mean?
 -make dialog explain the game better (explain how many stages)
 -position buttons better
 -display current stage
 -add explanation of semicolon (make funny)
 finish order of operations bridge
 -finish order of operations chart (cheat sheet)
 -finish bird dialog    
 -add order of operations fill in questions in between OOO Bridge stages
 refactor stages?
 code challenges
 add third player option
 character direction facing
 add a world edit mode
*/

/*
stage ideas:
 tornado
 lake
 river
 pond
 swamp
 
 snake
 primate
 
 general which-line-has-the-error game
 default value of variables
 - multiple variables defined on same line
 - maybe game on timer, have to get all answers before time expires (fuse to a bomb or something)
 - variables with incorrect assignments (ints getting decimal values etc.)
 - where variables are valid (inside {}) 
 - variable scope 
 - class(static), instance, and local variables
 - class variables always in scope
 - static methods using non-static variables
 - creating local variables with same name as instance variable
 removing unnecessary imports and adding in needed ones (java.lang)
 Command Line compiling and and arguments (.java and .class[bytecode])
 -main method's String array
 proper package declarations
 -accessing things from different packages
 -wildcards
 -different packages with same class name
 proper ways to write numbers (maybe a visit from Mr. Ocopus's brother?)
 -underscores and casting f, L, 0xE, 0b, 0B
 objects, references and garbage collection 
 -memory managed automatically
 -finalize() method
 constructors (and methods that look a lot like constructors...but aren't)
 comments
 encapsulation and immutability
 method overloading
 inheritance
 -class extending and interface implementing saves duplicate code
 java being object oriented and platform independant 
 -.class file can run on any computer with compatible JVM?
*/

import java.util.Arrays;
import java.util.Stack;
import java.time.LocalDateTime;
import java.io.File;
import java.io.FileWriter;
import java.io.Serializable;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.EOFException;
import java.io.FileNotFoundException;
import java.io.StreamCorruptedException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import javax.swing.JOptionPane;

import javax.script.ScriptEngineManager;
import javax.script.ScriptEngine;

ScriptEngine functionEvaluator = new ScriptEngineManager().getEngineByName("JavaScript");

PImage frame;

GameStates currentState = GameStates.TITLE_STATE;
GameStates previousState = GameStates.WORLD_MAP_STATE;
GameStates cachedState = currentState;

PFont arial;
PFont courier;

final static int F1_KEY = 97;
final static int F4_KEY = 100;
final static int F5_KEY = 101;
final static int F9_KEY = 105;
final static int resolutionWidth = 1024;
final static int resolutionHeight = 576;
final static int promptTextSize = 14;

final static int MOUSE_STATE = 0;
final static int KEYBOARD_STATE = 1;
int currentInputState = KEYBOARD_STATE;

int scaledMouseX;
int scaledMouseY;

int totalCharacters = 2;
int selectedCharacter = 0;

int scrollAmount;
int currentlySelectedSavedGame;

int currentWidth = 0;
int currentHeight = 0;
boolean fullScreen = false;
boolean canSave = true;
boolean ctrlDown = false;
boolean altDown = false;

boolean saveGameDeletionVarification;
int saveGameDeltionIndex;

float loadGameScrollAmt;

boolean DEBUG = true;

String dataFolderPath;

PImage robotImage;
PImage alienImage;

PImage robotPortrait;
PImage alienPortrait;

Player player;
Background worldMapBackground;
Background currentBackground;
Camera camera;

Stage variablesCaveStage;
Stage importsShackStage;
Stage mainMethodsMazeStage;
Stage oooBridgeStage;

ArrayList<StageImage> stageImages;
ArrayList<Stage> completedStages;
ArrayList<SaveState> savedGames;


void setup() {
  dataFolderPath = dataPath("");
  arial = createFont("Arial", 96);
  courier = createFont("Courier New bold", 96);

  robotImage = loadImage("robot.png");
  alienImage = loadImage("alien.png");

  player = new Player();
  worldMapBackground = new Background();

  camera = new Camera();
  stageImages = new ArrayList<StageImage>();
  stageImages.add(new StageImage("cave.png", GameStates.VARIABLES_CAVE_STATE, 400, 350));
  stageImages.add(new StageImage("shack.png", GameStates.IMPORTS_SHACK_STATE, 400, 750));
  stageImages.add(new StageImage("hedge.png", GameStates.MAIN_METHODS_MAZE_STATE, 200, 550));
  stageImages.add(new StageImage("bridge.png", GameStates.OOO_BRIDGE_STATE, 600, 600));
  stageImages.add(new StageImage("volcano.png", GameStates.OOO_BRIDGE_STATE, 1200, 600));
  stageImages.add(new StageImage("lighthouse.png", GameStates.OOO_BRIDGE_STATE, 900, 900));
  

  fullScreen(P2D);
  ((PGraphicsOpenGL)g).textureSampling(3); //disable texture filtering
  surface.setSize(resolutionWidth, resolutionHeight);
  int nx = (displayWidth / 2) - (resolutionWidth / 2);
  int ny = (displayHeight / 2) - (resolutionHeight / 2);
  surface.setLocation(nx, ny);

  camera.xMargin = ((float)resolutionWidth / 2.5f);
  camera.yMargin = ((float)resolutionHeight / 2.5f);

  currentWidth = resolutionWidth;
  currentHeight = resolutionHeight;

  player.x = resolutionWidth / 2;
  player.y = resolutionHeight / 2;
  player.savedX = player.x;
  player.savedY = player.y;
  player.setImage(robotImage);

  worldMapBackground.image = loadImage("terrain.png");
  worldMapBackground.w = 1920;
  worldMapBackground.h = 1080;

  currentBackground = worldMapBackground;
  savedGames = getSavedGameStates();
}

void draw() {
  resetDialogChoiceYPos();
  resetTextBoxYPos();
  switch(currentState) {
  case TITLE_STATE:
    {
      background(50, 100, 200);
      textSize(72);
      fill(255);
      text("Journey", 350, 150);
      text("Across", 330, 220);
      text("Various", 330, 290);
      text("Adventures", 330, 360);

      dialogChoiceYPos -= 30;
      if (renderDialogChoice("Start New Game")) {
        currentState = GameStates.CHARACTER_SELECT_STATE;
      }
      if (savedGames.size() > 0 && renderDialogChoice("Continue")) {
        currentState = GameStates.LOAD_GAME_STATE;
        background(50, 100, 200);
        image(robotImage, 0, 0);
        robotPortrait = get(0, 0, robotImage.width, robotImage.height / 2);
        background(50, 100, 200);
        image(alienImage, 0, 0);
        alienPortrait = get(0, 0, alienImage.width, alienImage.height - 15);
        currentlySelectedSavedGame = 0;
      }
      if (renderDialogChoice("How To Play")) {
        cachedState = currentState;
        previousState = currentState;
        currentState = GameStates.HOW_TO_PLAY_STATE;
      }
      break;
    }
  case LOAD_GAME_STATE:
    {
      
      background(50, 100, 200);
      strokeWeight(10);
      boolean del = false;
      float delY = 0;
      float margin = 25;
      float mx2 = margin * 2;
      float ts = 36;
      float h = 150;
      float x = margin;
      float y = margin - loadGameScrollAmt;
      float w = resolutionWidth - mx2;
      float dx = resolutionWidth - margin - 100;
      
      for (int i = 0; i < savedGames.size(); i++) {
        color boxColor = color(0, 0, 0, 200);
        color textColor = color(255);
        color delColor = color(255);
        if (currentInputState == MOUSE_STATE && checkMouseInBounds(x, y, w, h)) {
          boxColor = color(50, 50, 50, 200);
          textColor = color(200, 200, 0);
          if (checkMouseInBounds(dx, y, resolutionWidth - margin - dx, h)) {
            fill(255);
            textSize(14);
            del = true;
            delY = y;
            delColor = color(200, 0, 0);
            if (mousePressed && mouseButton == LEFT) {
              saveGameDeletionVarification = true;
              saveGameDeltionIndex = i;
            }
          }
          if (!saveGameDeletionVarification && mousePressed && mouseButton == LEFT) {
            loadSaveState(i); 
            break;
          }
        } else if (currentInputState == KEYBOARD_STATE && currentlySelectedSavedGame == i) {
          boxColor = color(50, 50, 50, 200);
          textColor = color(200, 200, 0);
          if (checkEnterInput()) {
            loadSaveState(i); 
            break;
          } else if (keyPressed && keyCode == UP) {
            keyCode = 0;
            keyPressed = false;
            currentlySelectedSavedGame--;
          } else if (keyPressed && keyCode == DOWN) {
            keyCode = 0;
            keyPressed = false;
            currentlySelectedSavedGame++;
          } else if (keyPressed && keyCode == LEFT) {
            keyCode = 0;
            keyPressed = false;
            currentlySelectedSavedGame--;
          } else if (keyPressed && keyCode == RIGHT) {
            keyCode = 0;
            keyPressed = false;
            currentlySelectedSavedGame++;
          }

          if (currentlySelectedSavedGame < 0) {
            currentlySelectedSavedGame = savedGames.size() - 1;
          } else if (currentlySelectedSavedGame > savedGames.size() - 1) {
            currentlySelectedSavedGame = 0;
          }
        } else if (keyPressed && keyCode == DELETE) {
          keyPressed = false;
          keyCode = 0;
        }
        SaveState s = savedGames.get(i);
        fill(boxColor);
        rect(x, y, w, h, 20);
        line(dx, y, dx, y + h);
        if (s.player == 0) {
          image(robotPortrait, mx2, y + (h / 2) - (robotPortrait.height * 3 / 2), robotPortrait.width * 3, robotPortrait.height * 3);
        } else if (s.player == 1) {
          image(alienPortrait, mx2, y + (h / 2) - (alienPortrait.height * 3/ 2), alienPortrait.width * 3, alienPortrait.height * 3);
        }

        fill(textColor);
        textSize(ts);
        text(s.name, x + 150, y + 60);
        text(s.time + "", x + 150, y + 120);
        textSize(96);
        fill(delColor);
        centeredText("X", dx, resolutionWidth - margin, y + 110);
        if (del) {
          textSize(14);
          fill(255);
          text("Click to Delete", dx, delY);
        }
        y += h + margin;
      }
      strokeWeight(1);
      
      
      
      if(y <= resolutionHeight - margin){
        loadGameScrollAmt--;
      }else{
        loadGameScrollAmt += scrollAmount * 20;
      }
      if (loadGameScrollAmt < 0) {
        loadGameScrollAmt = 0;
      }

      if (saveGameDeletionVarification) {
        renderTextBox("Are you sure you want to delete this saved game?");
        if (renderDialogChoice("Yes. Delete it")) {
          savedGames.remove(saveGameDeltionIndex);
          saveGame(savedGames);
          if (savedGames.size() == 0) {
            currentState = GameStates.TITLE_STATE;
          }
          saveGameDeletionVarification = false;
        }
        if (renderDialogChoice("No. Keep it")) {
          saveGameDeletionVarification = false;
        }
      }
      break;
    }
  case CHARACTER_SELECT_STATE:
    {
      int rx = 200;
      int ry = 150;
      int rw = robotImage.width;
      int rh = robotImage.height;
      PImage ri;

      int ax = 600;
      int ay = 150;
      int aw = alienImage.width;
      int ah = alienImage.height;
      PImage ai;

      if (checkMouseInBounds(rx, ry, rw * 5, rh * 5)) {
        background(100, 150, 255); 
        image(robotImage, rx, ry, rw, rh);
        ri = get(rx, ry, rw, rh / 2);

        if (mousePressed && mouseButton == LEFT) {
          mousePressed = false;
          mouseButton = 0;
          selectedCharacter = 0;
        }
      } else {
        background(70, 120, 220);
        image(robotImage, rx, ry, rw, rh);
        ri = get(rx, ry, rw, rh / 2);
      }

      if (checkMouseInBounds(ax, ay, aw * 5, ah * 5)) {
        background(100, 150, 255);
        image(alienImage, ax, ay, aw, ah);
        ai = get(ax, ay, aw, ah - 15);
        if (mousePressed && mouseButton == LEFT) {
          mousePressed = false;
          mouseButton = 0;
          selectedCharacter = 1;
        }
      } else {
        background(70, 120, 220);
        image(alienImage, ax, ay, aw, ah);
        ai = get(ax, ay, aw, ah - 15);
      }

      background(50, 100, 200);

      int b = 15;
      fill(255, 255, 0);
      if (selectedCharacter == 0) {
        rect(rx - b, ry - b, rw * 5 + b * 2, rh * 5 + b * 2);
      } else if (selectedCharacter == 1) {
        rect(ax - b, ay - b, aw * 5 + b * 2, ah * 5 + b * 2);
      }

      strokeWeight(5);
      rect(rx, ry, rw * 5, rh * 5);
      image(ri, rx, ry, rw * 5, rh * 5);
      rect(ax, ay, aw * 5, ah * 5);
      image(ai, ax, ay, aw * 5, ah * 5);
      strokeWeight(1);
      String text = "Choose Your Character";
      renderTextBox(50, text);
      String np = "Type Your Name and Press ENTER To Begin";
      textSize(24);
      float npw = textWidth(np);
      fill(255);
      text(np, resolutionWidth / 2 - npw / 2, resolutionHeight - 85);

      String input = renderInputBox();
      if (input != null && !input.trim().equals("")) {
        if (selectedCharacter == 0) player.setImage(robotImage);
        else if (selectedCharacter == 1) player.setImage(alienImage);
        player.name = input;
        currentState = GameStates.WORLD_MAP_STATE;
        saveGame();
      }
      break;
    }
  case MENU_SCREEN_STATE:
    {
      background(50, 100, 200);
      dialogChoiceYPos = 200;
      if (renderDialogChoice("RETURN TO THE GAME")) {
        currentState = previousState;
      }
      if (renderDialogChoice("RETURN TO THE TITLE SCREEN")) {
        currentState = GameStates.TITLE_STATE;
      }
      if (renderDialogChoice("HOW TO PLAY")) {
        cachedState = currentState;
        currentState = GameStates.HOW_TO_PLAY_STATE;
      }
      if (renderDialogChoice("EXIT THE PROGRAM")) {
        System.exit(0);
      }
      break;
    }
  case HOW_TO_PLAY_STATE:
    {
      background(50, 100, 200);
      textSize(72);
      fill(255);
      textBoxYPos = 50;
      renderTextBox("w: move up", 
        "a: move left", 
        "s: move down", 
        "d: move right", 
        "SPACE: interact", 
        "F1: toggle full screen mode", 
        "ESCAPE: view menu screen", 
        "You can use either the MOUSE", 
        "or the ARROW KEYS + ENTER to", 
        "select options");

      fill(255);
      textSize(24);
      String t = "Press ENTER, SPACE or Click the Mouse to Return to the Previous Screen";
      text(t, resolutionWidth / 2 - textWidth(t) / 2, resolutionHeight - 30);


      if (checkInteraction() || checkEnterInput() || mousePressed) {
        currentState = cachedState;
      }
      break;
    }
  case WORLD_MAP_STATE:
    {
      player.update();
      camera.update();

      image(worldMapBackground.image, -camera.x, -camera.y, worldMapBackground.w, worldMapBackground.h);

      drawStageImages();
      StageImage c = checkPlayerStageIntersection();
      if (c != null) {
        fill(255);
        textSize(promptTextSize);
        text("Press Space to Begin Stage", c.x - camera.x, c.y - camera.y);
        if (checkInteraction()) {
          currentState = c.state;
        }
      }
      for (int i = 0; i < stageImages.size(); i++) {
        StageImage s = stageImages.get(i);
        if (s.completed) {
          drawCheck(s.x - camera.x, s.y - camera.y);
        }
      }
      image(player.image, player.x, player.y, player.w, player.h);
      break;
    }
  case VARIABLES_CAVE_STATE:
    {
      if (variablesCaveStage == null) {
        variablesCaveStage = new VariablesCave(stageImages.get(0));
      }
      background(currentBackground.clr);
      player.update();
      camera.update();
      if (!variablesCaveStage.update()) variablesCaveStage = null;
      image(player.image, player.x, player.y, player.w, player.h);
      break;
    }
  case IMPORTS_SHACK_STATE:
    {
      if (importsShackStage == null) {
        importsShackStage = new ImportsShack(stageImages.get(1));
      }
      background(currentBackground.clr);
      player.update();
      camera.update();
      if (!importsShackStage.update()) importsShackStage = null;
      image(player.image, player.x, player.y, player.w, player.h);
      break;
    }

  case MAIN_METHODS_MAZE_STATE:
    {
      if (mainMethodsMazeStage == null) {
        mainMethodsMazeStage = new MainMethodsMaze(stageImages.get(2));
      }
      background(currentBackground.clr);
      player.update();
      camera.update();
      if (!mainMethodsMazeStage.update()) mainMethodsMazeStage = null;
      image(player.image, player.x, player.y, player.w, player.h);

      break;
    }
  case OOO_BRIDGE_STATE:
    {
      if (oooBridgeStage == null) {
        oooBridgeStage = new OOOBridge(stageImages.get(3));
      }
      background(currentBackground.clr);

      if (!oooBridgeStage.update()) oooBridgeStage = null;


      break;
    }
  }

  if (fullScreen) {
    frame = get(0, 0, resolutionWidth, resolutionHeight);
    image(frame, 0, 0, width, height);
    scaledMouseX = (int)((float)mouseX * (float)resolutionWidth / (float)width);
    scaledMouseY = (int)((float)mouseY * (float)resolutionHeight / (float)height);
  } else {
    scaledMouseX = mouseX;
    scaledMouseY = mouseY;
  }

  scrollAmount = 0;
}

void keyPressed() {
  if (recievingTextInput && key != CODED && keyCode != BACKSPACE && keyCode != ENTER) {
    inputBoxString += key;
  }
  switch(keyCode) {
  case ESC: 
    {
      if (currentState != GameStates.MENU_SCREEN_STATE) {
        cachedState = currentState;

        previousState = currentState;

        currentState = GameStates.MENU_SCREEN_STATE;
      } else {
        currentState = cachedState;
      }
      key = 0;
      break;
    }
  case ENTER: 
    {
      enterInput = true;
      break;
    }
  case CONTROL: 
    {
      ctrlDown = true;
      break;
    }
  case ALT: 
    {
      altDown = true;
      break;
    }
  case BACKSPACE: 
    {
      if (recievingTextInput) {
        if (ctrlDown) {
          inputBoxString = "";
        } else {
          if (inputBoxString.length() > 0) {
            inputBoxString = inputBoxString.substring(0, inputBoxString.length() - 1);
          }
        }
      }
      break;
    }
  case UP:
    {
      if (currentState == GameStates.CHARACTER_SELECT_STATE) {
        selectedCharacter++;
        if (selectedCharacter >= totalCharacters) {
          selectedCharacter = 0;
        }
      } else {
        highlightededDialogChoice--;
        if (highlightededDialogChoice < 0) {
          highlightededDialogChoice = dialogMax - 1;
        }
      }
      currentInputState = KEYBOARD_STATE;
      break;
    }
  case DOWN:
    {
      if (currentState == GameStates.CHARACTER_SELECT_STATE) {
        selectedCharacter--;
        if (selectedCharacter < 0) {
          selectedCharacter = totalCharacters - 1;
        }
      } else {
        highlightededDialogChoice++;
        if (highlightededDialogChoice >= dialogMax) {
          highlightededDialogChoice = 0;
        }
      }
      currentInputState = KEYBOARD_STATE;
      break;
    }
  case RIGHT:
    {
      if (currentState == GameStates.CHARACTER_SELECT_STATE) {
        selectedCharacter++;
        if (selectedCharacter >= totalCharacters) {
          selectedCharacter = 0;
        }
      } else {
        highlightededDialogChoice--;
        if (highlightededDialogChoice < 0) {
          highlightededDialogChoice = dialogMax - 1;
        }
      }
      currentInputState = KEYBOARD_STATE;
      break;
    }
  case LEFT:
    {
      if (currentState == GameStates.CHARACTER_SELECT_STATE) {
        selectedCharacter--;
        if (selectedCharacter < 0) {
          selectedCharacter = totalCharacters - 1;
        }
      } else {
        highlightededDialogChoice++;
        if (highlightededDialogChoice >= dialogMax) {
          highlightededDialogChoice = 0;
        }
      }
      currentInputState = KEYBOARD_STATE;
      break;
    }
  case F1_KEY:
    {
      toggleFullScreen();
      break;
    }
  case F4_KEY:
    {
      if (altDown) {
        System.exit(0);
      }
      break;
    }
  case F5_KEY:
    {
      saveGame(); 
      break;
    }
  case F9_KEY:
    {
      loadSaveState(1);
      break;
    }
  }

  switch(key) {
  case 'w':
    {
      player.up = true;
      break;
    }
  case 'a':
    {
      player.left = true;
      break;
    }
  case 's':
    {
      player.down = true;
      break;
    }
  case 'd':
    {
      player.right = true;
      break;
    }
  case ' ':
    {
      if (DEBUG && currentState == GameStates.TITLE_STATE) {
        currentState = GameStates.WORLD_MAP_STATE;
        player.name = "";
      }
      interaction = true;
      break;
    }
  }
}

void keyReleased() { 
  switch(keyCode) {
  case ENTER: 
    {
      enterInput = false;
      break;
    }
  case CONTROL: 
    {
      ctrlDown = false;
      break;
    }
  case ALT: 
    {
      altDown = false;
      break;
    }
  }
  switch(key) {
    case (int)'w':
    {
      player.up = false;
      break;
    }
    case (int)'a':
    {
      player.left = false;
      break;
    }
    case (int)'s':
    {
      player.down = false;
      break;
    }
    case (int)'d':
    {
      player.right = false;
      break;
    }
    case (int)' ':
    {
      interaction = false;
      break;
    }
  }
}

void mouseMoved() {
  currentInputState = MOUSE_STATE;
}

void mousePressed() {
  currentInputState = MOUSE_STATE;
}

void mouseWheel(MouseEvent e) {
  scrollAmount = e.getCount();
}

void toggleFullScreen() {
  fullScreen = !fullScreen;
  if (fullScreen) {
    surface.setSize(displayWidth, displayHeight);
    surface.setLocation(0, 0);
  } else {
    surface.setSize(resolutionWidth, resolutionHeight);
    int nx = (displayWidth / 2) - (resolutionWidth / 2);
    int ny = (displayHeight / 2) - (resolutionHeight / 2);
    surface.setLocation(nx, ny);
  }
}
