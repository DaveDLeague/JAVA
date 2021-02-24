class Player {
  PImage image;
  static final float MAX_SPEED = 7;
  static final float ACCELERATION = 1;
  static final float FRICTION = 0.5;
  
  float x;
  float y;
  float w;
  float h;
  float xSpeed;
  float ySpeed;

  boolean up;
  boolean down;
  boolean left;
  boolean right;

  void update() {
    if (up) {
      ySpeed -= ACCELERATION;
      if (ySpeed < -MAX_SPEED) {
        ySpeed = -MAX_SPEED;
      }
    }
    if (down) {
      ySpeed += ACCELERATION;
      if (ySpeed > MAX_SPEED) {
        ySpeed = MAX_SPEED;
      }
    }
    if (left) {
      xSpeed -= ACCELERATION;
      if (xSpeed < -MAX_SPEED) {
        xSpeed = -MAX_SPEED;
      }
    }
    if (right) {
      xSpeed += ACCELERATION;
      if (xSpeed > MAX_SPEED) {
        xSpeed = MAX_SPEED;
      }
    }
    if(xSpeed > 0){
       xSpeed -= FRICTION; 
    }else if(xSpeed < 0){
       xSpeed += FRICTION; 
    }
    if(ySpeed > 0){
       ySpeed -= FRICTION; 
    }else if(ySpeed < 0){
       ySpeed += FRICTION; 
    }
    
    x += xSpeed;
    y += ySpeed;
    
    if(x < 0) x = 0;
    else if(x > width - w) x = width - w;
    if(y < 0) y = 0;
    else if(y > height - h) y = height - h;
  }
}
