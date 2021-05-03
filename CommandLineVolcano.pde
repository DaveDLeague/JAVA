class CommandLineVolcano extends Stage { 
    CommandLineVolcano(){
        exitX = resolutionWidth / 2;
        exitY = resolutionHeight / 2;
        exitW = 70;
        exitH = 70;
        
        host = loadImage("snake.png");
        hostX = 700;
        hostY = 100;
    }
  
  
    boolean update(){
      boolean ret = true;
      background(0, 20, 70);
      player.update();
      camera.update();
      
      image(host, hostX - camera.x, hostY - camera.y, host.width, host.height);
      
      fill(200);
      float ex = exitX - camera.x;
      float ey = exitY - camera.y;
      ellipse(ex, ey, exitW, exitH);
      if(checkIntersection(player.x, player.y, player.w, player. h, ex - 35, ey - 35, exitW, exitH)){
        fill(255);
        textSize(promptTextSize);
        text("Press SPACE to Exit Stage", ex - 100, ey - 30);
        if(checkInteraction()){
           ret = false;
           returnToWorld();
        }
      }
      
      image(player.image, player.x, player.y, player.w, player.h);
      
      
      return ret;
    }
}
