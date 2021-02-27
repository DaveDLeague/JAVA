float dialogChoiceYPos = resolutionHeight - resolutionHeight / 4;
final float dialogChoiseYIncrement = 60;
final color defaultDialogBoxOffColor = color(50, 100, 200, 196);
final color defaultDialogBoxOnColor = color(105, 155, 255, 196);
final color defaultDialogTextOffColor = color(255);
final color defaultDialogTextOnColor = color(255, 255, 0);

float textBoxYPos = resolutionHeight / 4;
final float textBoxYIncrement = 60;
final float textBoxTextSize = 24;

enum GameStates {
  TITLE_STATE, WORLD_MAP_STATE, VARIABLES_CAVE_STATE, IMPORTS_SHACK_STATE, MAIN_METHODS_MAZE_STATE, HOW_TO_PLAY_STATE
}

class Background {
  PImage image;
  float w;
  float h;

  public Background() {
  }
  public Background(float w, float h) {
    this.w = w;
    this.h = h;
  }
}

class StageImage {
  PImage image;
  GameStates state;
  float x; 
  float y;
  boolean completed;

  public StageImage(String file, GameStates state, float x, float y) {
    this.image = loadImage(file);
    this.state = state;
    this.x = x;
    this.y = y;
  }
}

class Camera {
  public float x;
  public float y;
  public float xMargin;
  public float yMargin;

  void update() {
    if (x < currentBackground.w - resolutionWidth && player.x > resolutionWidth - xMargin) {
      x += player.x - (resolutionWidth - xMargin);
      player.x = resolutionWidth - xMargin;
    } else if (x > 0 && player.x + player.w < xMargin) {
      x += player.x + player.w - xMargin;
      player.x = xMargin - player.w;
    }
    if (y < currentBackground.h - resolutionHeight && player.y > resolutionHeight - yMargin) {
      y += player.y - (resolutionHeight - yMargin);
      player.y = resolutionHeight - yMargin;
    } else if (y > 0 && player.y + player.h < yMargin) {
      y += player.y + player.h - yMargin;
      player.y = yMargin - player.h;
    }

    if (x < 0) x = 0;
    else if (x > currentBackground.w - resolutionWidth) x = currentBackground.w - resolutionWidth;
    if (y < 0) y = 0;
    else if (y > currentBackground.h - resolutionHeight) y = currentBackground.h - resolutionHeight;
  }
}

class SolidBlock {
  float x;
  float y;
  float w;
  float h;

  public SolidBlock() {
  }
  public SolidBlock(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

class PushBox {
  float x;
  float y;
  float w;
  float h;

  public PushBox() {
  }
  public PushBox(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
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

boolean checkIntersection(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if (x1 + w1 < x2 || x1 > x2 + w2 || y1 + h1 < y2 || y1 > y2 + h2) {
    return false;
  }

  return true;
}

boolean handleSolidBlockCollision(SolidBlock block) {
  boolean ret = false;

  float bx = block.x - camera.x;
  float by = block.y - camera.y;

  float nx = player.x + player.xSpeed;
  float ny = player.y + player.ySpeed;

  if (player.xSpeed > 0) {
    if (nx + player.w > bx && nx < bx && ny + player.h > by && ny < by + block.h) {
      player.xSpeed = 0;
      player.x = bx - player.w;
      ret = true;
    }
  } else if (player.xSpeed < 0) {
    if (nx < bx + block.w && nx + player.w > bx + block.w && ny + player.h > by && ny < by + block.h) {
      player.xSpeed = 0;
      player.x = bx + block.w;
      ret = true;
    }
  }
  if (player.ySpeed > 0) {
    if (ny + player.h > by && ny < by && player.x + player.w > bx && player.x < bx + block.w) {
      player.ySpeed = 0;
      player.y = by - player.h;
      ret = true;
    }
  } else if (player.ySpeed < 0) {
    if (ny < by + block.h && ny + player.h > by + block.h && player.x + player.w > bx && player.x < bx + block.w) {
      player.ySpeed = 0;
      player.y = by + block.h;
      ret = true;
    }
  }
  return ret;
}

boolean handlePushBoxCollision(PushBox box) {
  boolean ret = false;

  float bx = box.x - camera.x;
  float by = box.y - camera.y;

  float nx = player.x + player.xSpeed;
  float ny = player.y + player.ySpeed;

  if (player.xSpeed > 0 && nx < bx && nx + player.w > bx && ny + player.h > by && ny < by + box.h) {
    box.x += player.xSpeed;
    if (box.x + box.w > currentBackground.w) {
      box.x = currentBackground.w - box.w;
      player.xSpeed = 0;
      player.x = box.x - player.w - camera.x;
    }
    ret = true;
  } else if (player.xSpeed < 0 && nx + player.w > bx + box.w && nx < bx + box.w && ny + player.h > by && ny < by + box.h) {
    box.x += player.xSpeed;
    if (box.x < 0) {
      box.x = 0;
      player.xSpeed = 0;
      player.x = box.x + box.w;
    }
    ret = true;
  }

  if (player.ySpeed > 0 && ny < by && ny + player.h > by && nx < bx + box.w && nx + player.w > bx) {
    box.y += player.ySpeed;
    if (box.y + box.h > currentBackground.h) {
      box.y = currentBackground.h - box.h;
      player.ySpeed = 0;
      player.y = box.y - box.h - camera.y;
    }
    ret = true;
  } else if (player.ySpeed < 0 && ny + player.h > by + box.h && ny < by + box.h && nx < bx + box.w && nx + player.w > bx) {
    box.y += player.ySpeed;
    if (box.y < 0) {
      box.y = 0;
      player.ySpeed = 0;
      player.y = box.y + box.h;
    }
    ret = true;
  }

  return ret;
}



void resetDialogChoiceYPos() {
  dialogChoiceYPos = resolutionHeight - resolutionHeight / 4;
}

boolean renderDialogChoice(String text) {
  float h = textBoxTextSize;
  textSize(h);
  float tw = textWidth(text);
  float x = resolutionWidth / 2 - tw / 2;
  color bc = defaultDialogBoxOffColor;
  color tc = defaultDialogTextOffColor;
  boolean ret = false;
  if (scaledMouseX > x - 10 && scaledMouseX < x + tw + 10 && 
    scaledMouseY > dialogChoiceYPos - 10 && scaledMouseY < dialogChoiceYPos + h + 10) {
    bc = defaultDialogBoxOnColor;
    tc = defaultDialogTextOnColor;

    if (mousePressed && mouseButton == LEFT) {
      mousePressed = false;
      ret = true;
    }
  }
  renderTextBox(dialogChoiceYPos, bc, tc, text);
  dialogChoiceYPos += dialogChoiseYIncrement;
  return ret;
}

void resetTextBoxYPos() {
  textBoxYPos = resolutionHeight / 4;
}

void renderTextBox(String... text) {
  renderTextBox(textBoxYPos, text);
  textBoxYPos += textBoxYIncrement;
}

void renderTextBox(float y, String... text) {
  renderTextBox(y, color(100, 100, 100, 196), color(255), text);
}

void renderTextBox(float y, color boxColor, color textColor, String... text) {
  float h = textBoxTextSize;
  textSize(h);
  float w = 0;
  for (int i = 0; i < text.length; i++) {
    float tw = textWidth(text[i]);
    if (tw > w) w = tw;
  }
  float x = resolutionWidth / 2 - w / 2;
  fill(boxColor);
  float bh = (h * 1.5) + (h * text.length - 1);
  rect(x - 5, y - h / 2, w + 10, bh, 7);
  for (int i = 0; i < text.length; i++) {
    float nw = textWidth(text[i]);
    float nx = resolutionWidth / 2 - nw / 2;
    fill(textColor);
    text(text[i], nx, y + h + (i * h));
  }
}

boolean renderPlayerButton(String text, float x, float y) {
  return renderPlayerButton(text, "Press SPACE to " + text, x, y); 
}

boolean renderPlayerButton(String text, String prompt, float x, float y) {
  boolean ret = false;

  float h = 36;
  textSize(h);
  float w = textWidth(text);
  float nx = x - camera.x;
  float ny = y - camera.y;
  fill(0, 0, 255);
  rect(nx - 10, ny - 10, w + 20, h + 20, 7);
  fill(255);
  text(text, nx, ny + h - 5);

  if (checkIntersection(player.x, player.y, player.w, player.w, nx, ny, w, h)) {
    textSize(promptTextSize);
    fill(255);
    text(prompt, nx, ny);
    if (keyPressed && key == ' ') {
      key = 0;
      ret = true;
    }
  }

  return ret;
}
