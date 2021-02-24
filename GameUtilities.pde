float dialogChoiceYPos = height - height / 4;
final float dialogChoiseYIncrement = 60;
final color defaultDialogBoxColor = color(50, 100, 200, 196);
final color defaultDialogTextOffColor = color(255);
final color defaultDialogTextOnColor = color(255, 255, 0);

float textBoxYPos = height / 4;
final float textBoxYIncrement = 60;
final float textBoxTextSize = 24;

enum GameStates {
  TITLE_STATE, WORLD_MAP_STATE, VARIABLES_CAVE_STATE, IMPORTS_SHACK_STATE
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
    if (x < currentBackground.w - width && player.x > width - xMargin) {
      x += player.x - (width - xMargin);
      player.x = width - xMargin;
    } else if (x > 0 && player.x + player.w < xMargin) {
      x += player.x + player.w - xMargin;
      player.x = xMargin - player.w;
    }
    if (y < currentBackground.h - height && player.y > height - yMargin) {
      y += player.y - (height - yMargin);
      player.y = height - yMargin;
    } else if (y > 0 && player.y + player.h < yMargin) {
      y += player.y + player.h - yMargin;
      player.y = yMargin - player.h;
    }

    if (x < 0) x = 0;
    else if (x > currentBackground.w - width) x = currentBackground.w - width;
    if (y < 0) y = 0;
    else if (y > currentBackground.h - height) y = currentBackground.h - height;
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
  } else if (player.xSpeed < 0 && nx + player.w > bx + box.w && nx < bx + box.w && ny + player.h > by && ny < by + box.h) {
    box.x += player.xSpeed;
    if (box.x < 0) {
      box.x = 0;
      player.xSpeed = 0;
      player.x = box.x + box.w;
    }
  }

  if (player.ySpeed > 0 && ny < by && ny + player.h > by && nx < bx + box.w && nx + player.w > bx) {
    box.y += player.ySpeed;
    if (box.y + box.h > currentBackground.h) {
      box.y = currentBackground.h - box.h;
      player.ySpeed = 0;
      player.y = box.y - box.h - camera.y;
    }
  } else if (player.ySpeed < 0 && ny + player.h > by + box.h && ny < by + box.h && nx < bx + box.w && nx + player.w > bx) {
    box.y += player.ySpeed;
    if (box.y < 0) {
      box.y = 0;
      player.ySpeed = 0;
      player.y = box.y + box.h;
    }
  }

  return ret;
}

public void resetDialogChoiceYPos() {
  dialogChoiceYPos = height - height / 4;
}

boolean renderDialogChoice(String text) {
  float h = textBoxTextSize;
  textSize(h);
  float tw = textWidth(text);
  renderTextBox(dialogChoiceYPos, text);
  float x = width / 2 - tw / 2;
  color tc = defaultDialogTextOffColor;
  boolean ret = false;
  if (mouseX > x - 10 && mouseX < x + tw + 10 && mouseY > dialogChoiceYPos - 10 && mouseY < dialogChoiceYPos + h + 10) {
    tc = defaultDialogTextOnColor;
    if (mousePressed && mouseButton == LEFT) {
      mousePressed = false;
      ret = true;
    }
  }
  renderTextBox(dialogChoiceYPos, defaultDialogBoxColor, tc, text);
  dialogChoiceYPos += dialogChoiseYIncrement;
  return ret;
}

void resetTextBoxYPos() {
  textBoxYPos = height / 4;
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
  float x = width / 2 - w / 2;
  fill(boxColor);
  float bh = (h * 1.5) + (h * text.length - 1);
  rect(x - 5, y - h / 2, w + 10, bh, 7);
  for (int i = 0; i < text.length; i++) {
    float nw = textWidth(text[i]);
    float nx = width / 2 - nw / 2;
    fill(textColor);
    text(text[i], nx, y + h + (i * h));
  }
}

boolean renderPlayerButton(String text, float x, float y){
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
  
  if(checkIntersection(player.x, player.y, player.w, player.w, nx, ny, w, h)){
    textSize(promptTextSize);
    fill(255);
    text("Press SPACE to " + text, nx, ny);
    if(keyPressed && key == ' '){
      key = 0;
      ret = true;
    }
  }
  
  return ret;
}
