class Variable {
  String name;
  float x;
  float y;
  float w;
  float h;
  
  public Variable(String name, float x, float y){
    textFont(courier);
    this.name = name;
    this.x = x;
    this.y = y;
    this.h = 24;
    textSize(this.h);
    this.w = textWidth(name);
    println(this.w);
    textFont(arial);
  }
}

class VariableCave {
  Variable[] variables = new Variable[1];

  public PImage host;
  public color variableColor;
  public float hostX = 500;
  public float hostY = 500;

  public TextBox dialog1;
  public TextBox dialog2;
  public TextBox dialog3;

  public DialogChoice choice1;
  public DialogChoice choice2;

  public final int searchState = 0;
  public final int greetingState = 1;
  public final int inquireState = 2;
  public final int gatherState = 3;
  public int currentState = searchState;
}

boolean checkIntersection(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if (x1 + w1 < x2 || x1 > x2 + w2 || y1 + h1 < y2 || y1 > y2 + h2) {
    return false;
  }

  return true;
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
  variableCave.choice1 = new DialogChoice("OK!");
  variableCave.choice2 = new DialogChoice("How do I know which ones are valid?");

  variableCave.variableColor = color(200, 200, 255);

  variableCave.variables[0] = new Variable("THIS IS A VARIABLE", 100, 100);
}

void updateVariables(){
  textFont(courier);

 for(int i = 0; i < variableCave.variables.length; i++){
    Variable v = variableCave.variables[i];
    textSize(v.h);
    float nx = v.x - camera.x;
    float ny = v.y - camera.y;
    fill(75, 75, 75, 200);
    rect(nx, ny - v.h, v.w, v.h);
    fill(variableCave.variableColor);
    text(v.name, nx, ny);
 }
 textFont(arial);
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
      if (variableCave.choice1.update()) {
        variableCave.currentState = variableCave.gatherState;
      }
      break;
    }
  case 3:
    {
      updateVariables();
      break;
    }
  }


  if (checkForExit(stages[0])) {
    if (keyPressed && key == ' ') {
      variableCave.currentState = variableCave.searchState;
      currentState = GameStates.WORLD_MAP_STATE;
      key = 0;
    }
  }
}
