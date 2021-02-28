/* //<>//
 TODO:
 finish imports shack
 refactor stages?
 code challenges
 add save and load games
 add third player option
 add order of operations bridge
 dialog choice selection with keyboard
 */

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

int scaledMouseX;
int scaledMouseY;

int currentWidth = 0;
int currentHeight = 0;
boolean fullScreen = false;
boolean canSave = true;

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

ArrayList<StageImage> stageImages;
ArrayList<Stage> completedStages;

SaveState saveState = new SaveState();

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

  fullScreen(P2D);
  surface.setSize(resolutionWidth, resolutionHeight);
  int nx = (displayWidth / 2) - (resolutionWidth / 2);
  int ny = (displayHeight / 2) - (resolutionHeight / 2);
  surface.setLocation(nx + displayWidth, ny);

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
      int ry = 200;
      int rw = robotImage.width;
      int rh = robotImage.height;
      PImage ri;

      int ax = 600;
      int ay = 200;
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
          player.setImage(robotImage);
          currentState = GameStates.WORLD_MAP_STATE;
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
          player.setImage(alienImage);
          currentState = GameStates.WORLD_MAP_STATE;
        }
      } else {
        background(70, 120, 220);
        image(alienImage, ax, ay, aw, ah);
        ai = get(ax, ay, aw, ah - 15);
      }




      background(50, 100, 200);
      String text = "Choose Your Character";
      renderTextBox(100, text);
      strokeWeight(5);
      rect(rx, ry, rw * 5, rh * 5);
      image(ri, rx, ry, rw * 5, rh * 5);

      rect(ax, ay, aw * 5, ah * 5);
      image(ai, ax, ay, aw * 5, ah * 5);

      strokeWeight(1);
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
        "SPACE BAR: interact", 
        "ENTER: toggle full screen mode", 
        "ESCAPE: bring up options", 
        "use the mouse to select options");

      fill(255);
      textSize(24);
      String t = "press any key to return";
      text(t, resolutionWidth / 2 - textWidth(t) / 2, resolutionHeight - 30);


      if (keyPressed) {
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
      background(0);
      if (importsShackStage == null) {
        importsShackStage = new ImportsShack(stageImages.get(1));
      }
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
      toggleFullScreen();
      break;
    }
  case F1_KEY:
    {
      if (canSave) {
        saveState.player = 0;
        saveGame(saveState);
        canSave = false;
      }
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
      if (currentState == GameStates.TITLE_STATE) {
        currentState = GameStates.WORLD_MAP_STATE;
      }
      interaction = true;
      break;
    }
  }
}

void keyReleased() {
  switch(keyCode) {
  case F1_KEY: 
    {
      canSave = true;
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
      canInteract = true;
      break;
    }
  }
}

void toggleFullScreen() {
  fullScreen = !fullScreen;
  if (fullScreen) {
    surface.setSize(displayWidth, displayHeight);
    surface.setLocation(displayWidth, 0);
  } else {
    surface.setSize(resolutionWidth, resolutionHeight);
    int nx = (displayWidth / 2) - (resolutionWidth / 2);
    int ny = (displayHeight / 2) - (resolutionHeight / 2);
    surface.setLocation(nx + displayWidth, ny);
  }
}
