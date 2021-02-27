/* //<>//
 TODO:
 fix door enter exit bug
 fix hedge maze bug
 finish imports shack
 finish variables cave
 refactor stages
 make main method maze
 code challenges
 add save and load games
 add player selection
 add order of operations bridge
 */

import java.util.Stack;
import javax.swing.JOptionPane;

PImage frame;

GameStates currentState = GameStates.TITLE_STATE;

PFont arial;
PFont courier;

final static int resolutionWidth = 1024;
final static int resolutionHeight = 576;
final static int promptTextSize = 14;

int scaledMouseX;
int scaledMouseY;

int currentWidth = 0;
int currentHeight = 0;
boolean fullScreen = false;

Player player;
Background worldMapBackground;
Background currentBackground;
Camera camera;

Stage variablesCaveStage;
Stage importsShackStage;
Stage mainMethodsMazeStage;

ArrayList<StageImage> stageImages;
ArrayList<Stage> completedStages;

void setup() {
  arial = createFont("Arial", 96);//createFont("arial.ttf", 96);
  courier = createFont("Courier New", 96);

  player = new Player();
  worldMapBackground = new Background();

  camera = new Camera();
  stageImages = new ArrayList<StageImage>();
  stageImages.add(new StageImage("cave.png", GameStates.VARIABLES_CAVE_STATE, 1200, 350));
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
  player.image = loadImage("robot.png");
  player.w = player.image.width;
  player.h = player.image.height;

  worldMapBackground.image = loadImage("terrain.png");
  worldMapBackground.w = 1920;
  worldMapBackground.h = 1080;

  currentBackground = worldMapBackground;
}


void draw() {
  scaledMouseX = (int)((float)mouseX * (float)resolutionWidth / (float)width);
  scaledMouseY = (int)((float)mouseY * (float)resolutionHeight / (float)height);

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
        currentState = GameStates.WORLD_MAP_STATE;
      }
      if (renderDialogChoice("Continue")) {
        currentState = GameStates.WORLD_MAP_STATE;
      }
      if (renderDialogChoice("How To Play")) {
        currentState = GameStates.HOW_TO_PLAY_STATE;
      }
      break;
    }
  case HOW_TO_PLAY_STATE:
    {
      background(50, 100, 200);
      textSize(72);
      fill(255);
      textBoxYPos = 50;
      renderTextBox("w: move up");
      renderTextBox("a: move left");
      renderTextBox("s: move down");
      renderTextBox("d: move right");
      renderTextBox("SPACE BAR: perform action");
      renderTextBox("ENTER: toggle full screen mode");
      renderTextBox("ESCAPE: bring up options");
      renderTextBox("use the mouse to select options");
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
        if (keyPressed && key == ' ') {
          key = 0;
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
      background(0);
      if (variablesCaveStage == null) {
        variablesCaveStage = new VariablesCave(stageImages.get(0));
      }
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
      background(0);
      if (mainMethodsMazeStage == null) {
        mainMethodsMazeStage = new MainMethodsMaze(stageImages.get(2));
      }
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
      break;
    }
  }
}

void keyReleased() {
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
