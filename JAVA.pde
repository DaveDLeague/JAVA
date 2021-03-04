/* //<>//
 TODO:
 finish imports shack
 finish order of operations bridge
 add options screen
 add save and load games
 refactor stages?
 code challenges
 add third player option
 character direction facing
 add a world edit mode
 */

import java.util.Arrays;
import java.util.Stack;
import java.io.File;
import java.io.FileWriter;
import java.io.Serializable;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import javax.swing.JOptionPane;

PImage frame;

GameStates currentState = GameStates.TITLE_STATE;

PFont arial;
PFont courier;

final static int F1_KEY = 97;
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

int currentWidth = 0;
int currentHeight = 0;
boolean fullScreen = false;
boolean canSave = true;
boolean ctrlDown = false;

boolean DEBUG = true;

String dataFolderPath;

PImage robotImage;
PImage alienImage;

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
  player.setImage(robotImage);

  worldMapBackground.image = loadImage("terrain.png");
  worldMapBackground.w = 1920;
  worldMapBackground.h = 1080;

  currentBackground = worldMapBackground;
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
      if (renderDialogChoice("Continue")) {
        currentState = GameStates.WORLD_MAP_STATE;
      }
      if (renderDialogChoice("How To Play")) {
        currentState = GameStates.HOW_TO_PLAY_STATE;
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
        if(selectedCharacter == 0) player.setImage(robotImage);
        else if(selectedCharacter == 1) player.setImage(alienImage);
        player.name = input;
        currentState = GameStates.WORLD_MAP_STATE;
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
                    "ESCAPE: exit program", 
                    "You can use either the MOUSE",
                    "or the ARROW KEYS + ENTER to",
                    "select options");

      fill(255);
      textSize(24);
      String t = "Press SPACE to Return to the Previous Screen";
      text(t, resolutionWidth / 2 - textWidth(t) / 2, resolutionHeight - 30);


      if (checkInteraction()) {
        currentState = GameStates.TITLE_STATE;
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
      image(player.image, player.x, player.y, player.w, player.h);

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
}

void keyPressed() {
  if (recievingTextInput && key != CODED && keyCode != BACKSPACE && keyCode != ENTER) {
    inputBoxString += key;
  }
  switch(keyCode) {
  case ESC: 
    {
      int res = JOptionPane.YES_OPTION;//JOptionPane.showConfirmDialog(null, "Are you sure you want to exit?", "", JOptionPane.YES_NO_OPTION);
      if (res == JOptionPane.YES_OPTION) {
        System.exit(0);
      } else {
        key = 0;
      }
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

void mouseMoved(){
   currentInputState = MOUSE_STATE;
}

void mousePressed(){
  currentInputState = MOUSE_STATE;
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
