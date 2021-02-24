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
