abstract class Stage {
  GameStates state;
  Background background;
  StageImage image;
  PImage host;
  float hostX;
  float hostY;
  float x;
  float y;
  float w;
  float h;
  float exitX;
  float exitY;
  float exitW;
  float exitH;
  int currentStageState = 0;

  abstract boolean update();

  Stage(StageImage image){
    this.image = image;
  }

  boolean checkForExit() {
    float sx =  exitX - camera.x;
    float sy = exitY - camera.y;
    if (checkIntersection(player.x, player.y, player.w, player.h, sx, sy, exitW, exitH)) {
      textSize(promptTextSize);
      fill(255);
      text("Press SPACE to Exit the Stage", sx, sy);
      return true;
    }
    return false;
  }
}

StageImage checkPlayerStageIntersection() {
  for (int i = 0; i < stageImages.size(); i++) {
    StageImage c = stageImages.get(i);
    float cx = c.x - camera.x;
    float cy = c.y - camera.y;
    if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, c.image.width, c.image.height)) {
      return c;
    }
  }
  return null;
}

void drawStageImages() {
  for (int i = 0; i < stageImages.size(); i++) {
    StageImage c = stageImages.get(i);
    image(c.image, c.x - camera.x, c.y - camera.y, c.image.width, c.image.height);
  }
}
