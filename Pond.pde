class Pond extends Stage {
  Pond() {
  }
  boolean update() {
    boolean ret = true;

    background(0);

  
    fill(200);
    rect(500, 200, 50, 90);
    player.update();
    image(player.image, player.x, player.y, player.w, player.h);

    if (checkIntersection(player.x, player.y, player.w, player.h, 500, 200, 50, 90)) {
      if (checkInteraction()) {
        completed = true;
        ret = false;
      }
    }

    return ret;
  }
}
