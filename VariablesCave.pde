class VariablesCave extends Stage { //<>//
  class Variable {
    String name;
    float x;
    float y;
    float w;
    float h;

    public Variable(String name, float x, float y) {
      textFont(courier);
      this.name = name;
      this.x = x;
      this.y = y;
      this.h = 24;
      textSize(this.h);
      this.w = textWidth(name);
      textFont(arial);
    }
  }
  public ArrayList<Variable> variables = new ArrayList<Variable>();
  public ArrayList<Variable> collectedVariables = new ArrayList<Variable>();
  public String[] correctAnswers = {
    "my_variable", "$mooth_operator", "$__$__$123"
  };

  public color variableColor;

  public final int searchState = 0;
  public final int greetingState = 1;
  public final int inquireState = 2;
  public final int gatherState = 3;
  public final int checkState = 4;

  public boolean collected = false;

  public VariablesCave(StageImage image) {
    super(image); 
    initialize();
  }

  public void initialize() {
    x = 1200;
    y = 350;
    hostX = 500;
    hostY = 500;
    exitX = x;
    exitY = y;
    exitW = 50;
    exitH = 90;
    w = image.image.width;
    h = image.image.height;
    state = GameStates.VARIABLES_CAVE_STATE;

    host = loadImage("octopus.png");

    variableColor = color(200, 200, 255);

    variables.add(new Variable("my variable", 100, 100));
    variables.add(new Variable("my_variable", 1000, 700));
    variables.add(new Variable("$mooth_operator", 100, 300));
    variables.add( new Variable("1Int4U", 500, 900));
    variables.add(new Variable("$__$__$123", 700, 1000));
  }

  public boolean update() {
    boolean ret = true;

    float cx = hostX - camera.x;
    float cy = hostY - camera.y;
    fill(200);
    rect(exitX - camera.x, exitY - camera.y, exitW, exitH, 18, 18, 0, 0);
    image(host, cx, cy, host.width, host.height);

    switch(currentStageState) {
    case searchState:
      {
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to talk to the Octopus", cx, cy); 
          if (keyPressed && key == ' ') {
            key = 0;
            currentStageState = greetingState;
          }
        }
        break;
      }
    case greetingState:
      {
        renderTextBox("Bring me all of the variable names that are valid in Java.");
        if (renderDialogChoice("Okay!")) {
          currentStageState = gatherState;
        }
        if (renderDialogChoice("How do I know which ones are valid?")) {
          currentStageState = inquireState;
        }
        break;
      }
    case inquireState:
      {
        renderTextBox("Java variables can only consist of numbers, letters, underscores,", 
          "and currency symbols. They absolutely cannot begin with a number!", 
          "They cannot have spaces and cannot have the same name as a reserved Java keyword.");
        if (renderDialogChoice("Okay!")) {
          currentStageState = gatherState;
        }
        break;
      }
    case gatherState:
      {
        updateVariables();
        if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, host.width, host.height)) {
          fill(255);
          textSize(promptTextSize);
          text("Press SPACE to give the variables to the Octopus", cx, cy); 
          if (keyPressed && key == ' ') {
            key = 0;
            if (checkForAllCollectedVariables()) {
              collected = true;
            } else {
              collected = false;
            }
            currentStageState = checkState;
          }
        }
        break;
      }
    case checkState:
      {
        if (collected) {
          renderTextBox("Great! You got them all!", "Now leave me alone with my variables!"); 
          image.completed = true;
        } else {
          renderTextBox("What is this? You trying to give me bad variables?", 
            "Come back when you're ready to give me what I ask for.");
        }
        break;
      }
    }


    if (checkForExit()) {
      if (keyPressed && key == ' ') {
        currentState = GameStates.WORLD_MAP_STATE;
        ret = false;
        key = 0;
      }
    }
    return ret;
  }

  public void render() {
  }

  void updateVariables() {
    textFont(courier);

    for (int i = 0; i < variables.size(); i++) {
      Variable v = variables.get(i);
      textSize(v.h);
      float nx = v.x - camera.x;
      float ny = v.y - camera.y;
      fill(75, 75, 75, 200);
      rect(nx - 5, ny - v.h, v.w + 10, v.h * 2, 3);
      fill(variableColor);
      text(v.name, nx, ny);

      if (checkIntersection(player.x, player.y, player.w, player.h, nx, ny, v.w, v.h)) {
        textFont(arial);
        textSize(promptTextSize);
        fill(255);
        text("Press SPACE to collect variable", nx, ny - 20);   
        textFont(courier);

        if (keyPressed && key == ' ') {
          key = 0;
          variables.remove(v); 
          collectedVariables.add(v);
        }
      }
    }
    textFont(arial);
  }

  boolean checkForAllCollectedVariables() {
    if (collectedVariables.size() != correctAnswers.length) return false;
    for (int i = 0; i < correctAnswers.length; i++) {
      boolean found = false;
      for (Variable v : collectedVariables) {
        if (v.name.equals(correctAnswers[i])) {
          found = true;
        }
      }
      if (!found) return false;
    }
    return true;
  }
}

//VariablesCave variableCave;

//void initializeVariableCave() {
//  variableCave = new VariablesCave();
//  variableCave.host = loadImage("octopus.png");

//  variableCave.variableColor = color(200, 200, 255);

//  variableCave.variables.add(new Variable("my variable", 100, 100));
//  variableCave.variables.add(new Variable("my_variable", 1000, 700));
//  variableCave.variables.add(new Variable("$mooth_operator", 100, 300));
//  variableCave.variables.add( new Variable("1Int4U", 500, 900));
//  variableCave.variables.add(new Variable("$__$__$123", 700, 1000));
//}

//void updateVariableCave() {
//  if (variableCave == null) {
//      initializeVariableCave();
//    }
//  float cx = variableCave.hostX - camera.x;
//  float cy = variableCave.hostY - camera.y;
//  fill(200);
//  rect(stages[0].exitX - camera.x, stages[0].exitY - camera.y, stages[0].exitW, stages[0].exitH, 18, 18, 0, 0);
//  image(variableCave.host, cx, cy, variableCave.host.width, variableCave.host.height);

//  switch(variableCave.currentState) {
//  case 0:
//    {
//      if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, variableCave.host.width, variableCave.host.height)) {
//        fill(255);
//        textSize(promptTextSize);
//        text("Press SPACE to talk to the Octopus", cx, cy); 
//        if (keyPressed && key == ' ') {
//          key = 0;
//          variableCave.currentState = variableCave.greetingState;
//        }
//      }
//      break;
//    }
//  case 1:
//    {
//      renderTextBox("Bring me all of the variable names that are valid in Java.");
//      if (renderDialogChoice("Okay!")) {
//        variableCave.currentState = variableCave.gatherState;
//      }
//      if (renderDialogChoice("How do I know which ones are valid?")) {
//        variableCave.currentState = variableCave.inquireState;
//      }
//      break;
//    }
//  case 2:
//    {
//      renderTextBox("Java variables can only consist of numbers, letters, underscores,", 
//                                     "and currency symbols. They absolutely cannot begin with a number!",
//                                     "They cannot have spaces and cannot have the same name as a reserved Java keyword.");
//      if (renderDialogChoice("Okay!")) {
//        variableCave.currentState = variableCave.gatherState;
//      }
//      break;
//    }
//  case 3:
//    {
//      updateVariables();
//      if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, variableCave.host.width, variableCave.host.height)) {
//        fill(255);
//        textSize(promptTextSize);
//        text("Press SPACE to give the variables to the Octopus", cx, cy); 
//        if (keyPressed && key == ' ') {
//          key = 0;
//          if (checkForAllCollectedVariables()) {
//            variableCave.collected = true;
//          } else {
//            variableCave.collected = false;
//          }
//          variableCave.currentState = variableCave.checkState;
//        }
//      }
//      break;
//    }
//  case 4:
//    {
//      if(variableCave.collected){
//        renderTextBox("Great! You got them all!", "Now leave me alone with my variables!"); 
//        stages[0].completed = true;
//      }else{
//        renderTextBox("What is this? You trying to give me bad variables?", 
//                                     "Come back when you're ready to give me what I ask for.");
//      }
//      break;
//    }
//  }


//  if (checkForExit(stages[0])) {
//    if (keyPressed && key == ' ') {
//      variableCave = null;
//      currentState = GameStates.WORLD_MAP_STATE;
//      key = 0;
//    }
//  }
//}
