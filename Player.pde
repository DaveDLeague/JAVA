class Player {
  PImage image;
  public static final float MAX_SPEED = 7;
  public static final float ACCELERATION = 1;
  public static final float FRICTION = 0.5;
  
  public float maxSpeed = 7;
  public float acceleration = 1;
  public float friction = 0.5;
  public float x;
  public float y;
  public float w;
  public float h;
  public float xSpeed;
  public float ySpeed;

  public boolean up;
  public boolean down;
  public boolean left;
  public boolean right;

  public void update() {
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
    
    x += xSpeed * xRatio;
    y += ySpeed * yRatio;
    
    if(x < 0) x = 0;
    else if(x > width - w) x = width - w;
    if(y < 0) y = 0;
    else if(y > height - h) y = height - h;
  }
}
