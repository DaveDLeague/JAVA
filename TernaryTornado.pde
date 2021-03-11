class TernaryTornado extends Stage {
  TernaryTornado(){
    camera.x = 0;
    camera.y = 0;
    exitX = 100;
    exitY = 100;
    exitW = 50;
    exitH = 90;
    host = loadImage("butterfly.png");
    hostX = exitX + 300;
    hostY = exitY + 150;
    player.x = exitX;
    player.y = exitY;
    
    background = new Background(resolutionWidth, resolutionHeight);
    background.clr = color(#9653A5);
    currentBackground = background;
  }
  
  boolean update(){
   boolean ret = true;
   background(background.clr);
   player.update();
   camera.update();
   fill(200);
   rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);
   image(host, hostX - camera.y, hostY - camera.x, host.width, host.height);
   
   image(player.image, player.x, player.y, player.w, player.h);
   if(checkForExit() && checkInteraction()){
     returnToWorld();
     ret = false;
   }
   return ret;
  }
}
