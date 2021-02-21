import javax.swing.JOptionPane;

GameStates currentState = GameStates.TITLE_STATE;

PFont arial;
PFont courier;

final int resolutionWidth = 1024;
final int resolutionHeight = 576;
final int totalStages = 1;
int currentWidth = 0;
int currentHeight = 0;
float xRatio = 0;
float yRatio = 0;
boolean fullScreen = false;

Player player;
Background worldMapBackground;
Background currentBackground;
Camera camera;
Stage[] stages;
ArrayList<Stage> completedStages;

void setup() {
  arial = createFont("arial.ttf", 32);
  courier = createFont("cour.ttf", 32);

  player = new Player();
  worldMapBackground = new Background();
  camera = new Camera();
  stages = new Stage[totalStages];
  stages[0] = new Stage();

  fullScreen(P2D);
  toggleFullScreen();
  checkForWindowResize();

  player.x = width / 2;
  player.y = height / 2;
  player.image = loadImage("robot.png");
  player.w = player.image.width;
  player.h = player.image.height;

  worldMapBackground.image = loadImage("terrain.png");
  worldMapBackground.w = 1920;
  worldMapBackground.h = 1080;

  stages[0].image = loadImage("cave.png");
  stages[0].x = 1200;
  stages[0].y = 350;
  stages[0].exitX = stages[0].x;
  stages[0].exitY = stages[0].y;
  stages[0].exitW = 50;
  stages[0].exitH = 90;
  stages[0].w = stages[0].image.width;
  stages[0].h = stages[0].image.height;
  stages[0].state = GameStates.VARIABLES_CAVE_STATE;

  currentBackground = worldMapBackground;
}

void draw() {
  checkForWindowResize();
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

      image(worldMapBackground.image, -camera.x, -camera.y, worldMapBackground.w * xRatio, worldMapBackground.h * yRatio);

      Stage c = checkPlayerStageIntersection();
      if (c != null) {
        fill(255);
        textSize(10);
        text("Press Space to Begin Stage", c.x - camera.x, c.y - camera.y);
        if (keyPressed && key == ' ') {
          key = 0;
          currentState = c.state;
        }
      }

      drawStages();
      image(player.image, player.x, player.y, player.w * xRatio, player.h * yRatio);
      break;
    }
  case VARIABLES_CAVE_STATE:
    {
      if (variableCave == null) {
        initializeVariableCave();
      }
      background(0);
      updateVariableCave();
      player.update();
      camera.update();
      image(player.image, player.x, player.y, player.w * xRatio, player.h * yRatio);
      break;
    }
  }
}

void checkForWindowResize() {
  if (currentWidth != width || currentHeight != height) {
    currentWidth = width;
    currentHeight = height;
    xRatio = (float)width / (float)resolutionWidth;
    yRatio = (float)height / (float)resolutionHeight;

    camera.xMargin = ((float)width / 2.5f);
    camera.yMargin = ((float)height / 2.5f);

    player.maxSpeed = Player.MAX_SPEED * xRatio;
    player.acceleration = Player.ACCELERATION * xRatio;
    player.friction = Player.FRICTION * xRatio;
    player.x *= xRatio * xRatio;
    player.y *= yRatio * yRatio;
  }
}

void toggleFullScreen() {
  if (fullScreen) {
    surface.setSize(displayWidth, displayHeight);
    surface.setLocation(0, 0);
  } else {
    surface.setSize(resolutionWidth, resolutionHeight);
    int nx = (displayWidth / 2) - (width / 2);
    int ny = (displayHeight / 2) - (height / 2);
    surface.setLocation(nx, ny);
  }
  fullScreen = !fullScreen;
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
