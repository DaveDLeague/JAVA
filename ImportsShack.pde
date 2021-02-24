class ImportsShack extends Stage {
  public final int searchState = 0;
  public final int greetingState = 1;
  public final int tutorialState = 2;
  public final int tutorialState2 = 3;
  public final int tutorialState3 = 4;
  public final int doorSearchState = 5;
  public final int packageGameState1 = 6;
  public boolean skipTutorial;
  
  Background gameBackground = new Background(resolutionWidth, resolutionHeight * 5);
  
  float bx = 400;
  float by = 750;
  float bw = 50;
  float bh = 50;
  
  public ImportsShack(StageImage image) {
    super(image); 
    initialize();
  }

  public void initialize() {
    x = 400;
    y = 750;
    exitX = x;
    exitY = y;
    exitW = 50;
    exitH = 90;
    hostX = exitX + 200;
    hostY = exitY;
    w = image.image.width;
    h = image.image.height;
    state = GameStates.IMPORTS_SHACK_STATE;
    host = loadImage("sloth.png");
    
    currentStageState = packageGameState1;
    currentBackground = gameBackground;
  }

  public boolean update() {
    boolean ret = true;
    float cx = hostX - camera.x;
    float cy = hostY - camera.y;
    fill(200);
    image(host, cx, cy, host.width, host.height);
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);

    switch(currentStageState) {
    case searchState:
      {
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Sloth", cx, cy); 
          if (keyPressed && key == ' ') {
            key = 0;
            currentStageState = greetingState;
          }
        }
        break;
      }
    case greetingState:
      {
        renderTextBox("Listen up because I'm going to talk fast.");
        if (renderDialogChoice("Okay. I'm listening.")) {
          currentStageState = tutorialState;
        } else if (renderDialogChoice("I already know what you're going to say.")) {
          currentStageState = doorSearchState;
          skipTutorial = true;
        }
        break;
      }
    case tutorialState:
      {
        renderTextBox("Java classes are placed into packages.", 
          "A package is really just a folder on the computer.", 
          "In order for one class to make objects of another class,", 
          "it has to declare what package that class is in.", 
          "Unless the two classes are in the same package, that is.");
        if (renderDialogChoice("Uh huh.")) {
          currentStageState = tutorialState2;
        }

        break;
      }
    case tutorialState2:
      {
        renderTextBox("There's a package named java.lang that is, ", 
          "imported automatically for every Java program.", 
          "That means any class can use the classes in that package", 
          "without importing or declaring that package.", 
          "This package has the String class, the primitive", 
          "Data types wrapper classes, and all the other", 
          "commonly used classes, You can look it", 
          "up in the docs to get a full list of ", 
          "classes in this package.");
        if (renderDialogChoice("I'm with you so far")) {
          currentStageState = tutorialState3;
        }

        break;
      }
    case tutorialState3:
      {
        renderTextBox("Go through the door to the right to start.", 
          "Put all the classes in the correct packages to finish.", 
          "Got it?");
        if (renderDialogChoice("Got it.")) {
          currentStageState = doorSearchState;
        }

        break;
      }
   
    case doorSearchState:
      {
        if(skipTutorial){
          renderTextBox("Oh! Um. Okay. Well, you better get to it then.");
        }
        fill(128, 40, 75);
        float dx = hostX + 400 - camera.x;
        float dy = hostY - camera.y;
        float dw = 50;
        float dh = 100;
        rect(dx, dy, dw, dh, 18, 18, 0, 0);
        
        if(checkIntersection(player.x, player.y, player.w, player.h, dx, dy, dw, dh)){
           textSize(promptTextSize);
           fill(255);
           text("Press SPACE to Begin Sorting Packages", dx, dy);
           if(keyPressed && key == ' '){
             key = 0;
             currentStageState = packageGameState1;
           }
        }
        break;
      }
      case packageGameState1:
      {
        background(128, 40, 75);
       
        fill(80);
        float nx = bx - camera.x;
        float ny = by - camera.y;
        handlePushableBoxCollision(nx, ny, bw, bh);
        rect(nx, ny, bw, bh);
        
        fill(255);
        rect(300 - camera.x, 500 - camera.y, 25, 25);
        
        break;
      }
    }
    if (currentStageState < packageGameState1 && checkForExit()) {
      if (keyPressed && key == ' ') {
        key = 0;
        currentState = GameStates.WORLD_MAP_STATE;
        ret = false;
      }
    }
    return ret;
  }

  public void render() {
  }
  
  boolean handlePushableBoxCollision(float bx, float by, float bw, float bh){
    boolean ret = false;
    
    float nx = player.x + player.xSpeed;
    float ny = player.y + player.ySpeed;
    
    if(player.xSpeed > 0 && nx < bx && nx + player.w > bx && ny + player.h > by && ny < by + bh){
      this.bx += player.xSpeed;
      if(this.bx + bw > currentBackground.w){
        this.bx = currentBackground.w - bw;
        player.xSpeed = 0;
        player.x = this.bx - player.w - camera.x;
      }
      
    }else if(player.xSpeed < 0 && nx + player.w > bx + bw && nx < bx + bw && ny + player.h > by && ny < by + bh){
      this.bx += player.xSpeed;
      if(this.bx < 0){
       this.bx = 0;
       player.xSpeed = 0;
       player.x = this.bx + bw;
      }
    }
    
    if(player.ySpeed > 0 && ny < by && ny + player.h > by && nx < bx + bw && nx + player.w > bx){
      this.by += player.ySpeed;
      if(this.by + bh > currentBackground.h){
       this.by = currentBackground.h - bh;
       player.ySpeed = 0;
       player.y = this.by - bh - camera.y;
      }
    }else if(player.ySpeed < 0 && ny + player.h > by + bh && ny < by + bh && nx < bx + bw && nx + player.w > bx){
      this.by += player.ySpeed;
      if(this.by < 0){
       this.by = 0;
       player.ySpeed = 0;
       player.y = this.by + bh;
      }
    }
    
    return ret;
  }
}
