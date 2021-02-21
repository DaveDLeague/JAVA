class Stage {
   GameStates state;
   Background background;
   PImage image;
   float x;
   float y;
   float w;
   float h;
   float exitX;
   float exitY;
   float exitW;
   float exitH;
}

boolean checkForExit(Stage s){
  float sx =  s.exitX - camera.x;
  float sy = s.exitY - camera.y;
   if(checkIntersection(player.x, player.y, player.w, player.h, sx, sy, s.exitW, s.exitH)){
     textSize(10);
     fill(255);
     text("Press SPACE to exit stage.", sx, sy);
     return true;
   }
   return false;
}
