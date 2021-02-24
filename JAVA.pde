/* //<>//
TODO:
 finish imports shack
 finish variables cave
 refactor stages
 make main method maze
 code challenges
 */

import javax.swing.JOptionPane;

GameStates currentState = GameStates.TITLE_STATE;

PFont arial;
PFont courier;

final int resolutionWidth = 1024;
final int resolutionHeight = 576;
final int promptTextSize = 14;

int currentWidth = 0;
int currentHeight = 0;
boolean fullScreen = false;

Player player;
Background worldMapBackground;
Background currentBackground;
Camera camera;

Stage variablesCaveStage;
Stage importsShackStage;

ArrayList<StageImage> stageImages;
ArrayList<Stage> completedStages;

void setup() {
  arial = createFont("arial.ttf", 96);
  courier = createFont("cour.ttf", 96);

  player = new Player();
  worldMapBackground = new Background();

  camera = new Camera();
  stageImages = new ArrayList<StageImage>();
  stageImages.add(new StageImage("cave.png", GameStates.VARIABLES_CAVE_STATE, 1200, 350));
  stageImages.add(new StageImage("shack.png", GameStates.IMPORTS_SHACK_STATE, 400, 750));

  fullScreen(P2D);
  surface.setSize(resolutionWidth, resolutionHeight);
  int nx = (displayWidth / 2) - (width / 2);
  int ny = (displayHeight / 2) - (height / 2);
  surface.setLocation(nx + displayWidth, ny);
  
  camera.xMargin = ((float)width / 2.5f);
  camera.yMargin = ((float)height / 2.5f);
  
  currentWidth = width;
  currentHeight = height;

  player.x = width / 2;
  player.y = height / 2;
  player.image = loadImage("robot.png");
  player.w = player.image.width;
  player.h = player.image.height;

  worldMapBackground.image = loadImage("terrain.png");
  worldMapBackground.w = 1920;
  worldMapBackground.h = 1080;

  currentBackground = worldMapBackground;
}

void drawCheck(float xp, float yp) {
  strokeWeight(7);
  stroke(0);
  line(xp - 5, yp - 5, xp, yp);
  line(xp, yp, xp + 10, yp - 10);
  strokeWeight(3);
  stroke(0, 255, 0);
  line(xp - 5, yp - 5, xp, yp);
  line(xp, yp, xp + 10, yp - 10);
  strokeWeight(1);
  stroke(0);
}

void draw() {
  resetDialogChoiceYPos();
  resetTextBoxYPos();
  switch(currentState) {
  case TITLE_STATE:
    {
      background(50, 100, 200);
      textSize(72);
      text("Journey", 200, 150);
      text("Across", 180, 220);
      text("Various", 180, 290);
      text("Adventures", 180, 360);
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
      if (!variablesCaveStage.update()) variablesCaveStage = null;
      player.update();
      camera.update();
      image(player.image, player.x, player.y, player.w, player.h);
      break;
    }
  case IMPORTS_SHACK_STATE:
    {
      background(0);
      if (importsShackStage == null) {
        importsShackStage = new ImportsShack(stageImages.get(1));
      }
      if (!importsShackStage.update()) importsShackStage = null;
      player.update();
      camera.update();
      image(player.image, player.x, player.y, player.w, player.h);
      break;
    }
  }
}

boolean checkIntersection(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if (x1 + w1 < x2 || x1 > x2 + w2 || y1 + h1 < y2 || y1 > y2 + h2) {
    return false;
  }

  return true;
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
      if (currentState == GameStates.TITLE_STATE) {
        currentState = GameStates.WORLD_MAP_STATE;
      }
      //toggleFullScreen();
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
