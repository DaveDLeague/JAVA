class Camera {
  public float x;
  public float y;
  public float xMargin;
  public float yMargin;

  void update() {
    if (x < currentBackground.w - width && player.x > width - xMargin) {
      x += player.x - (width - xMargin);
      player.x = width - xMargin;
    }else if (x > 0 && player.x + player.w < xMargin) {
      x += player.x + player.w - xMargin;
      player.x = xMargin - player.w;
    }
    if (y < currentBackground.h - height && player.y > height - yMargin) {
      y += player.y - (height - yMargin);
      player.y = height - yMargin;
    }else if (y > 0 && player.y + player.h < yMargin) {
      y += player.y + player.h - yMargin;
      player.y = yMargin - player.h;
    }
    
    if(x < 0) x = 0;
    else if(x > currentBackground.w - width) x = currentBackground.w - width;
    if(y < 0) y = 0;
    else if(y > currentBackground.h - height) y = currentBackground.h - height;
  }
}
