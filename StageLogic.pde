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

class VariableCave {
  public ArrayList<Variable> variables = new ArrayList<Variable>();
  public ArrayList<Variable> collectedVariables = new ArrayList<Variable>();
  public String[] correctAnswers = {
    "my_variable", "$mooth_operator", "$__$__$123"
  };
  
  public PImage host;
  public color variableColor;
  public float hostX = 500;
  public float hostY = 500;
  
  public TextBox dialog1;
  public TextBox dialog2;
  public TextBox dialog3;
  public TextBox dialog4;
  public TextBox dialog5;
  public TextBox dialog6;
  public TextBox dialog7;
  public TextBox dialog8;

  public DialogChoice choice1;
  public DialogChoice choice2;

  public final int searchState = 0;
  public final int greetingState = 1;
  public final int inquireState = 2;
  public final int gatherState = 3;
  public final int checkState = 4;
  public int currentState = searchState;

  public boolean collected = false;
}

Stage checkPlayerStageIntersection() {
  for (int i = 0; i < stages.length; i++) {
    Stage c = stages[i];
    float cx = c.x - camera.x;
    float cy = c.y - camera.y;
    if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, c.w, c.h)) {
      return c;
    }
  }
  return null;
}

void drawStages() {
  for (int i = 0; i < stages.length; i++) {
    Stage c = stages[i];
    image(stages[i].image, c.x - camera.x, c.y - camera.y, c.w, c.h);
  }
}

VariableCave variableCave;

void initializeVariableCave() {
  variableCave = new VariableCave();
  variableCave.host = loadImage("octopus.png");
  variableCave.dialog1 = new TextBox("Bring me all of the variable names that are valid in Java.");
  variableCave.dialog2 = new TextBox("Java variables can only consist of numbers, letters, underscores,");
  variableCave.dialog3 = new TextBox("and currency symbols. They absolutely cannot begin with a number!");
  variableCave.dialog4 = new TextBox("The cannot have spaces and cannot have the same name as a reserved Java keyword.");
  variableCave.dialog5 = new TextBox("Thank you! You got them all!");
  variableCave.dialog6 = new TextBox("What is this? You trying to give me bad variables?");
  variableCave.dialog7 = new TextBox("Come back when you're ready to give me what I ask for.");
  variableCave.dialog8 = new TextBox("Now leave me alone with my variables!");
  variableCave.choice1 = new DialogChoice("OK!");
  variableCave.choice2 = new DialogChoice("How do I know which ones are valid?");

  variableCave.variableColor = color(200, 200, 255);

  variableCave.variables.add(new Variable("my variable", 100, 100));
  variableCave.variables.add(new Variable("my_variable", 1000, 700));
  variableCave.variables.add(new Variable("$mooth_operator", 100, 300));
  variableCave.variables.add( new Variable("1Int4U", 500, 900));
  variableCave.variables.add(new Variable("$__$__$123", 700, 1000));
}

void updateVariables() {
  textFont(courier);

  for (int i = 0; i < variableCave.variables.size(); i++) {
    Variable v = variableCave.variables.get(i);
    textSize(v.h);
    float nx = v.x - camera.x;
    float ny = v.y - camera.y;
    fill(75, 75, 75, 200);
    rect(nx - 5, ny - v.h, v.w + 10, v.h * 2, 3);
    fill(variableCave.variableColor);
    text(v.name, nx, ny);

    if (checkIntersection(player.x, player.y, player.w, player.h, nx, ny, v.w, v.h)) {
      textFont(arial);
      textSize(10);
      fill(255);
      text("Press SPACE to collect variable", nx, ny - 20);   
      textFont(courier);

      if (keyPressed && key == ' ') {
        variableCave.variables.remove(v); 
        variableCave.collectedVariables.add(v);
      }
    }
  }
  textFont(arial);
}

boolean checkForAllCollectedVariables() {
  if(variableCave.collectedVariables.size() != variableCave.correctAnswers.length) return false; //<>//
  for(int i = 0; i < variableCave.correctAnswers.length; i++){
    boolean found = false;
    for(Variable v : variableCave.collectedVariables){
      if(v.name.equals(variableCave.correctAnswers[i])){
        found = true; 
      }
    }
    if(!found) return false;
  }
  return true;
}

void updateVariableCave() {
  float cx = variableCave.hostX - camera.x;
  float cy = variableCave.hostY - camera.y;
  fill(200);
  rect(stages[0].exitX - camera.x, stages[0].exitY - camera.y, stages[0].exitW, stages[0].exitH, 18, 18, 0, 0);
  image(variableCave.host, cx, cy, variableCave.host.width, variableCave.host.height);

  switch(variableCave.currentState) {
  case 0:
    {
      if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, variableCave.host.width, variableCave.host.height)) {
        fill(255);
        textSize(10);
        text("Press SPACE to talk to the Octopus", cx, cy); 
        if (keyPressed && key == ' ') {
          key = 0;
          variableCave.currentState = variableCave.greetingState;
        }
      }
      break;
    }
  case 1:
    {
      variableCave.dialog1.render();
      if (variableCave.choice1.update()) {
        variableCave.currentState = variableCave.gatherState;
      }
      if (variableCave.choice2.update()) {
        variableCave.currentState = variableCave.inquireState;
      }
      break;
    }
  case 2:
    {
      variableCave.dialog2.render();
      variableCave.dialog3.render();
      variableCave.dialog4.render();
      if (variableCave.choice1.update()) {
        variableCave.currentState = variableCave.gatherState;
      }
      break;
    }
  case 3:
    {
      updateVariables();
      if (checkIntersection(player.x, player.y, player.w, player.h, cx, cy, variableCave.host.width, variableCave.host.height)) {
        fill(255);
        textSize(10);
        text("Press SPACE to give the variables to the Octopus", cx, cy); 
        if (keyPressed && key == ' ') {
          key = 0;
          if (checkForAllCollectedVariables()) {
            variableCave.collected = true;
          } else {
            variableCave.collected = false;
          }
          variableCave.currentState = variableCave.checkState;
        }
      }
      break;
    }
  case 4:
    {
      if(variableCave.collected){
        variableCave.dialog5.render(); 
        variableCave.dialog8.render(); 
      }else{
        variableCave.dialog6.render();
        variableCave.dialog7.render();
      }
      break;
    }
  }


  if (checkForExit(stages[0])) {
    if (keyPressed && key == ' ') {
      variableCave = null;
      currentState = GameStates.WORLD_MAP_STATE;
      key = 0;
    }
  }
}
