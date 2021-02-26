class Player {
  PImage image;
  float maxSpeed = 7;
  float acceleration = 1;
  float friction = 0.5;
  
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
      ySpeed -= acceleration;
      if (ySpeed < -maxSpeed) {
        ySpeed = -maxSpeed;
      }
    }
    if (down) {
      ySpeed += acceleration;
      if (ySpeed > maxSpeed) {
        ySpeed = maxSpeed;
      }
    }
    if (left) {
      xSpeed -= acceleration;
      if (xSpeed < -maxSpeed) {
        xSpeed = -maxSpeed;
      }
    }
    if (right) {
      xSpeed += acceleration;
      if (xSpeed > maxSpeed) {
        xSpeed = maxSpeed;
      }
    }
    if(xSpeed > 0){
       xSpeed -= friction; 
    }else if(xSpeed < 0){
       xSpeed += friction; 
    }
    if(ySpeed > 0){
       ySpeed -= friction; 
    }else if(ySpeed < 0){
       ySpeed += friction; 
    }
    
    x += xSpeed;
    y += ySpeed;
    
    if(x < 0) x = 0;
    else if(x > resolutionWidth - w) x = resolutionWidth - w;
    if(y < 0) y = 0;
    else if(y > resolutionHeight - h) y = resolutionHeight - h;
  }
}
